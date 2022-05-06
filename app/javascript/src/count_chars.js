document.addEventListener('DOMContentLoaded', () => {
  let textNeedCount = document.querySelectorAll('#admin_password, #admin_new_password, #admin_repeat_new_password, #admin_current_password');
  M.CharacterCounter.init(textNeedCount);
});
