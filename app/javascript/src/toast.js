const STYLES = {
  notice: 'teal',
  alert: 'red',
  warning: 'yellow darken-3'
}

document.addEventListener('DOMContentLoaded', () => {
  let toastsBlock = document.querySelector('#toasts')
  if (!toastsBlock) return

  let toasts = JSON.parse(toastsBlock.getAttribute('data-toasts'))

  for (let [toastType, message] of Object.entries(toasts)) {
    M.toast({ html: message, classes: STYLES[toastType] })
  }
})
