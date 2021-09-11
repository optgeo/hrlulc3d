import { YAML } from 'https://code4sabae.github.io/js/YAML.js'

const style = href => {
  const e = document.createElement('link')
  e.href = href
  e.rel = 'stylesheet'
  document.head.appendChild(e)
}

const script = src => {
  const e = document.createElement('script')
  e.src = src
  document.head.appendChild(e)
}

const init = () => {
  style('style.css')
  style('https://unpkg.com/maplibre-gl@1.15.2/dist/maplibre-gl.css')
  script('https://unpkg.com/maplibre-gl@1.15.2/dist/maplibre-gl.js')
  const map = document.createElement('div')
  map.id = 'map'
  document.body.appendChild(map)
}
init()

const showMap = async (texts) => {
  const map = new maplibregl.Map({
    container: 'map',
    hash: true,
    style: 'style.json',
    maxZoom: 17.8
  })
  map.addControl(new maplibregl.NavigationControl())
  map.addControl(new maplibregl.ScaleControl({
    maxWidth: 200, unit: 'metric'
  }))

  let voice = null
  for(let v of speechSynthesis.getVoices()) {
    console.log(v.name)
    if ([
      'Daniel',
      'Google UK English Male',
      'Microsoft Libby Online (Natural) - English (United Kingdom)'
    ].includes(v.name)) voice = v
  }

  const legend = {
    1: 'water',
    2: 'urban',
    3: 'rice paddy',
    4: 'crop',
    5: 'grassland',
    6: 'deciduous broad-leaved forest, or DBF',
    7: 'deciduous needle-leaved forest, or DNF',
    8: 'evergreen broad-leaved forest, or EBF',
    9: 'evergreen needle-leaved forest, or ENF',
    10: 'bare land',
    11: 'bamboo',
    12: 'solar panel'
  }

  map.on('load', () => {
    map.on('click', 'hrlulc', (e) => {
      let u = new SpeechSynthesisUtterance()
      u.lang = 'en-GB'
      u.text = legend[e.features[0].properties.a]
      if (voice) u.voice = voice
      speechSynthesis.cancel()
      speechSynthesis.speak(u)
    })

  })
}

const main = async () => {
  if (typeof maplibregl == 'undefined') {
    window.onload = () => {
      showMap()
    }
  } else {
    showMap()
  }
}
main()
