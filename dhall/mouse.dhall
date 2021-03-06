let AllOS = ./lib/all-os.dhall

let monpad = ./lib/monpad.dhall AllOS.Axis AllOS.Button

let Evdev = ./lib/evdev.dhall

let ButtonL = Evdev.Key

let ButtonW = {}

let axis =
      λ(a : Evdev.RelAxis) →
      λ(m : Double) →
        { linux = { axis = Evdev.Axis.Rel a, multiplier = m }
        , windows = {=}
        , mac = {=}
        }

let button =
      λ(x : Integer) →
      λ(y : Integer) →
      λ(linux : ButtonL) →
      λ(windows : ButtonW) →
      λ(name : Text) →
      λ(colour : monpad.Colour) →
        { element =
            monpad.Element.Button
              { buttonData = { linux, windows, mac = {=} }
              , colour
              , shape = monpad.Shape.Circle 150
              }
        , location = { x, y }
        , name
        , showName = False
        }

let layoutAll =
        { elements =
          [ button -300 +1650 ButtonL.BtnLeft {=} "Blue" monpad.cols.blue
          , button +300 +1650 ButtonL.BtnRight {=} "Red" monpad.cols.red
          , { element =
                monpad.Element.Slider
                  { radius = 90
                  , length = 500
                  , width = 80
                  , sliderColour = monpad.cols.yellow
                  , backgroundColour = monpad.cols.white
                  , vertical = True
                  , sliderData = axis Evdev.RelAxis.RelWheel 5.0
                  }
            , location = { x = +0, y = +1650 }
            , name = "Slider"
            , showName = False
            }
          , { element =
                monpad.Element.Stick
                  { radius = 140
                  , range = 420
                  , stickColour = monpad.cols.white
                  , backgroundColour = monpad.cols.grey
                  , stickDataX = axis Evdev.RelAxis.RelX 15.0
                  , stickDataY = axis Evdev.RelAxis.RelY 15.0
                  }
            , location = { x = +0, y = +900 }
            , name = "Stick"
            , showName = False
            }
          ]
        , viewBox = { x = -500, y = -2000, w = +1000, h = +2000 }
        }
      : monpad.Layout

in  monpad.mapLayout
      AllOS.AxisLinux
      AllOS.ButtonLinux
      (λ(a : AllOS.Axis) → a.linux)
      (λ(b : AllOS.Button) → b.linux)
      layoutAll
