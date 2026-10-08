Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @"
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class InnerFill {
  public static void Run(string path) {
    Bitmap b0 = new Bitmap(path);
    Bitmap b = new Bitmap(b0);
    b0.Dispose();
    int w = b.Width, h = b.Height;
    BitmapData d = b.LockBits(new Rectangle(0, 0, w, h), ImageLockMode.ReadWrite, PixelFormat.Format32bppArgb);
    byte[] px = new byte[w * h * 4];
    Marshal.Copy(d.Scan0, px, 0, px.Length);
    bool[] seen = new bool[w * h];
    Queue<int> q = new Queue<int>();
    double cx = w / 2.0, cy = h / 2.0, R = w / 2.0;
    foreach (double k in new double[] { 0.80, 0.84, 0.88 })
      for (int a = 0; a < 360; a += 5) {
        int x = (int)(cx + Math.Cos(a * Math.PI / 180) * R * k);
        int y = (int)(cy + Math.Sin(a * Math.PI / 180) * R * k);
        q.Enqueue(y * w + x);
      }
    while (q.Count > 0) {
      int i = q.Dequeue();
      if (seen[i]) continue;
      seen[i] = true;
      int o = i * 4;
      if (px[o + 3] < 200) continue;
      int bl = px[o], gr = px[o + 1], rd = px[o + 2];
      int mx = Math.Max(rd, Math.Max(gr, bl)), mn = Math.Min(rd, Math.Min(gr, bl));
      if (mn < 170 || mx - mn > 28) continue;
      px[o] = 255; px[o + 1] = 255; px[o + 2] = 255;
      int xx = i % w, yy = i / w;
      if (xx > 0) q.Enqueue(i - 1);
      if (xx < w - 1) q.Enqueue(i + 1);
      if (yy > 0) q.Enqueue(i - w);
      if (yy < h - 1) q.Enqueue(i + w);
    }
    Marshal.Copy(px, 0, d.Scan0, px.Length);
    b.UnlockBits(d);
    b.Save(path, ImageFormat.Png);
    b.Dispose();
  }
}
"@
foreach ($n in 'icon-sandwich.png','icon-eggcake.png','icon-burger.png','icon-hot.png','logo.png') {
  [InnerFill]::Run((Join-Path (Join-Path $PWD 'images\cut') $n))
  "ok $n"
}
