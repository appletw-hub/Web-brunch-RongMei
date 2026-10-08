// 餐點 icon：點擊切換浮動
document.querySelectorAll('.icon-btn').forEach((btn) => {
  btn.addEventListener('click', () => btn.classList.toggle('floating'));
});

// 菜單放大
const dlg = document.getElementById('menuDialog');
document.getElementById('menuOpen').addEventListener('click', () => dlg.showModal());
document.getElementById('menuClose').addEventListener('click', () => dlg.close());
dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });
