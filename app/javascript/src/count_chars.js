document.addEventListener('DOMContentLoaded', () => {
  let textNeedCount = document.querySelectorAll('#admin_password, #admin_password_confirmation');
  M.CharacterCounter.init(textNeedCount);
});
