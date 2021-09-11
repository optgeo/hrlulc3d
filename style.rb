require 'yaml'
require 'json'
require './constants'

center = [135.0, 35.0, 8]
gsi_style = JSON.parse($stdin.read)

style = <<-EOS
version: 8
center: #{center[0..1]}
zoom: #{center[2].to_i}
sprite: #{gsi_style['sprite']}
glyphs: #{gsi_style['glyphs']}
sources: 
  h:
    type: raster-dem
    url: "mapbox://mapbox.mapbox-terrain-dem-v1"
    tileSize: 512
    maxzoom: 14
  v: 
    type: vector
    minzoom: #{MINZOOM}
    maxzoom: #{MAXZOOM}
    attribution: "Credit: HRLULC ver.21.03, 2018/2020 (JAXA)"
    tiles: 
      - #{BASE_URL}/zxy/{z}/{x}/{y}.pbf
  i:
    type: raster
    minzoom: 2
    maxzoom: 18
    attribution: 国土地理院
    tileSize: 256
    tiles:
      - https://maps.gsi.go.jp/xyz/seamlessphoto/{z}/{x}/{y}.jpg
terrain:
  source: h
layers: 
  -
    id: sky
    type: sky
    paint: 
      sky-type: atmosphere
  -
    id: background
    type: background
    paint: 
      background-color: #{BACKGROUND_COLOR}
  - 
    id: hrlulc 
    type: fill
    source: v
    source-layer: hrlulc
    minzoom: #{MINZOOM}
    maxzoom: 18
    paint: 
      fill-outline-color: rgba(0, 0, 0, 0)
EOS

style = YAML.load(style)
style['layers'][2]['paint']['fill-color'] = COLOR_MAP

style['sources'].merge!(gsi_style['sources'])
gsi_style['layers'].each {|layer|
  layer.delete('metadata')
  style['layers'].insert(-1, layer)
}

print JSON.generate(style)
