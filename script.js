// 餐點 icon：點擊切換浮動
document.querySelectorAll('.icon-btn').forEach((btn) => {
  btn.addEventListener('click', () => btn.classList.toggle('floating'));
});

// 菜單放大
const dlg = document.getElementById('menuDialog');
document.getElementById('menuOpen').addEventListener('click', () => dlg.showModal());
document.getElementById('menuClose').addEventListener('click', () => dlg.close());
dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });

// iOS Safari 影片自動播放修復與觸控喚醒
function ensureVideoAutoplay() {
  const videos = document.querySelectorAll('video');
  videos.forEach((v) => {
    v.muted = true;
    v.defaultMuted = true;
    v.setAttribute('muted', '');
    v.setAttribute('playsinline', '');
    v.setAttribute('webkit-playsinline', '');

    const p = v.play();
    if (p !== undefined) {
      p.catch(() => {
        // 若受 iOS 低耗電模式或限制擋下，使用者碰觸或滑動螢幕時立即喚醒播放
        const unlock = () => {
          videos.forEach((video) => video.play());
          window.removeEventListener('touchstart', unlock);
          window.removeEventListener('scroll', unlock);
          window.removeEventListener('click', unlock);
        };
        window.addEventListener('touchstart', unlock, { once: true, passive: true });
        window.addEventListener('scroll', unlock, { once: true, passive: true });
        window.addEventListener('click', unlock, { once: true, passive: true });
      });
    }
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', ensureVideoAutoplay);
} else {
  ensureVideoAutoplay();
}
