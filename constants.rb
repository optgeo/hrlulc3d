require 'yaml'

LAYER = 'hrlulc'
PROPERTY = 'a'
MINZOOM = 0
MAXZOOM = 14

# vector tile style configurations
PHOTO_OPACITY = 0.5
BASE_STYLE_URL = 'https://gsi-cyberjapan.github.io/gsivectortile-mapbox-gl-js/pale.json'
BACKGROUND_COLOR = 'rgb(255, 255, 255)'
MASK_COLOR = 'rgb(189, 189, 189)'
COLOR_MAP = YAML.load <<-EOS
  - match
  -
    - get
    - #{PROPERTY}
  - 1
  - rgb(0, 0, 100)
  - 2
  - rgb(255, 0, 0)
  - 3
  - rgb(0, 128, 255)
  - 4
  - rgb(255, 193, 191)
  - 5
  - rgb(255, 255, 0)
  - 6
  - rgb(128, 255, 0)
  - 7
  - rgb(0, 255, 128)
  - 8
  - rgb(86, 172, 0)
  - 9
  - rgb(0, 172, 86)
  - 10
  - rgb(128, 100, 0)
  - 11
  - rgb(217, 240, 5)
  - 12
  - rgb(161, 41, 119)
  - rgba(0, 0, 0, 0)
EOS

# hosting configuration
BASE_URL = 'https://x.optgeo.org/hrlulc'
