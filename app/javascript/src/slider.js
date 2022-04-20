import noUiSlider from 'nouislider'
import 'nouislider/dist/nouislider.css'
import wNumb from 'wnumb/wNumb'

document.addEventListener('DOMContentLoaded', () => {
  const slider = document.querySelector('.price-slider')

  let minTextField = document.getElementById('min-price-output')
  let maxTextField = document.getElementById('max-price-output')

  const defaultMin = Number(minTextField.getAttribute('data-default'))
  const defaultMax = Number(maxTextField.getAttribute('data-default'))
  const stepsCount = 6

  const calculateRounding = (maxValue, steps) => {
    if (maxValue >= 10000 * steps) return 10000
    if (maxValue >= 1000 * steps) return 1000
    if (maxValue >= 1000 * steps) return 100
    if (maxValue >= 10 * steps) return 10

    return 1
  }
  const rounding = calculateRounding(defaultMax - defaultMin, stepsCount)

  noUiSlider.create(slider, {
    start: [defaultMin, defaultMax],
    connect: true,
    range: {
      'min': defaultMin,
      'max': defaultMax
    },
    format: wNumb({
      decimals: 0,
    }),
    pips: {
      mode: 'count',
      values: stepsCount,
      density: 4,
      format: wNumb({
        decimals: 0,
        prefix: '$',
        encoder: (value) => {
          if (value <= defaultMin) return value
          if (value >= defaultMax) return value

          return Math.ceil(value / rounding) * rounding
        }
      })
    }
  });

  if (defaultMax === 0) {
    slider.setAttribute('disabled', true)
  }

  let minSlider = document.querySelector('.noUi-handle.noUi-handle-lower')
  let maxSlider = document.querySelector('.noUi-handle.noUi-handle-upper')

  slider.noUiSlider.set([minTextField.value, maxTextField.value])

  minTextField.addEventListener('change', () => {
    slider.noUiSlider.set([minTextField.value, null])
  });

  maxTextField.addEventListener('change', () => {
    slider.noUiSlider.set([null, maxTextField.value])
  });

  slider.noUiSlider.on('update', () => {
    minTextField.value = minSlider.getAttribute('aria-valuetext')
    maxTextField.value = maxSlider.getAttribute('aria-valuetext')
  }, false);
})
