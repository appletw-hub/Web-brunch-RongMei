Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @"
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class Cutout {
  
  public static void Run(string src, string dst) {
    Bitmap b0 = new Bitmap(src);
    Bitmap b = new Bitmap(b0.Width, b0.Height, PixelFormat.Format32bppArgb);
    using (Graphics g = Graphics.FromImage(b)) g.DrawImage(b0, 0, 0, b0.Width, b0.Height);
    b0.Dispose();
    int w = b.Width, h = b.Height;
    BitmapData d = b.LockBits(new Rectangle(0, 0, w, h), ImageLockMode.ReadWrite, PixelFormat.Format32bppArgb);
    byte[] px = new byte[w * h * 4];
    Marshal.Copy(d.Scan0, px, 0, px.Length);
    bool[] seen = new bool[w * h];
    Queue<int> q = new Queue<int>();
    for (int x = 0; x < w; x++) { q.Enqueue(x); q.Enqueue((h - 1) * w + x); }
    for (int y = 0; y < h; y++) { q.Enqueue(y * w); q.Enqueue(y * w + w - 1); }
    while (q.Count > 0) {
      int i = q.Dequeue();
      if (seen[i]) continue;
      seen[i] = true;
      int o = i * 4;
      int bl = px[o], gr = px[o + 1], rd = px[o + 2];
      int mx = Math.Max(rd, Math.Max(gr, bl)), mn = Math.Min(rd, Math.Min(gr, bl));
      if (mn < 175 || mx - mn > 28) continue;
      px[o + 3] = 0;
      int x = i % w, y = i / w;
      if (x > 0) q.Enqueue(i - 1);
      if (x < w - 1) q.Enqueue(i + 1);
      if (y > 0) q.Enqueue(i - w);
      if (y < h - 1) q.Enqueue(i + w);
    }
    
    byte[] cp = (byte[])px.Clone();
    for (int y = 1; y < h - 1; y++) for (int x = 1; x < w - 1; x++) {
      int i = y * w + x, o = i * 4;
      if (cp[o + 3] == 0) continue;
      if (cp[(i - 1) * 4 + 3] == 0 || cp[(i + 1) * 4 + 3] == 0 || cp[(i - w) * 4 + 3] == 0 || cp[(i + w) * 4 + 3] == 0) {
        int mn = Math.Min(cp[o], Math.Min(cp[o + 1], cp[o + 2]));
        if (mn > 150) px[o + 3] = 110;
      }
    }
    Marshal.Copy(px, 0, d.Scan0, px.Length);
    b.UnlockBits(d);
    
    int minX = w, minY = h, maxX = 0, maxY = 0;
    for (int y = 0; y < h; y++) for (int x = 0; x < w; x++) {
      if (px[(y * w + x) * 4 + 3] > 0) {
        if (x < minX) minX = x; if (x > maxX) maxX = x;
        if (y < minY) minY = y; if (y > maxY) maxY = y;
      }
    }
    Rectangle r = new Rectangle(minX, minY, maxX - minX + 1, maxY - minY + 1);
    int side = Math.Max(r.Width, r.Height);
    Bitmap outB = new Bitmap(side, side, PixelFormat.Format32bppArgb);
    using (Graphics g = Graphics.FromImage(outB)) {
      g.Clear(Color.Transparent);
      g.DrawImage(b, new Rectangle((side - r.Width) / 2, (side - r.Height) / 2, r.Width, r.Height), r, GraphicsUnit.Pixel);
    }
    b.Dispose();
    
    Bitmap fin = new Bitmap(512, 512, PixelFormat.Format32bppArgb);
    using (Graphics g = Graphics.FromImage(fin)) {
      g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
      g.Clear(Color.Transparent);
      g.DrawImage(outB, 0, 0, 512, 512);
    }
    outB.Dispose();
    fin.Save(dst, ImageFormat.Png);
    fin.Dispose();
  }
}
"@

$dir = Join-Path $PSScriptRoot 'images'
$out = Join-Path $dir 'cut'
New-Item -ItemType Directory -Force -Path $out | Out-Null
foreach ($n in 'icon-sandwich.png','icon-eggcake.png','icon-burger.png','icon-hot.png','logo.jpg') {
  $dst = Join-Path $out ([IO.Path]::GetFileNameWithoutExtension($n) + '.png')
  [Cutout]::Run((Join-Path $dir $n), $dst)
  "ok $n"
}
