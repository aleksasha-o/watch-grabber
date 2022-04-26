document.addEventListener('DOMContentLoaded', () => {
  const elems = document.querySelectorAll('select')
  const instances = M.FormSelect.init(elems)

  instances.forEach((instance) => {
    const placeholder = instance.el.getAttribute('data-placeholder')

    instance.input.setAttribute('placeholder', placeholder)
  })
});
