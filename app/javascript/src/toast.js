const STYLES = {
  notice: 'pink',
  alert: 'red',
  warning: 'grey'
}

document.addEventListener('DOMContentLoaded', () => {
  let toastsBlock = document.querySelector('#toasts')
  if (!toastsBlock) return

  let toasts = JSON.parse(toastsBlock.getAttribute('data-toasts'))

  for (let [toastType, message] of Object.entries(toasts)) {
    M.toast({ html: message, classes: STYLES[toastType] })
  }
})
