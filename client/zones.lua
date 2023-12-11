Config = Config or {}

road1 =
  PolyZone:Create(
  {
    vector2(1533.09, -2842.9),
    vector2(1522.54, -2838.21),
    vector2(1528.15, -2828.52),
    vector2(1536.82, -2833.18)
  },
  {
    name = "Ada Köprüsü",
    minZ = 42.0,
    maxZ = 52.0,
    debugGrid = false,
    gridDivisions = 25
  }
)

road2 =
  PolyZone:Create(
  {
    vector2(4573.55, -4312.97),
    vector2(4585.75, -4318.17),
    vector2(4581.66, -4328.53),
    vector2(4568.97, -4322.51)
  },
  {
    name = "Ada Köprüsü",
    minZ = 4.0,
    maxZ = 12.0,
    debugGrid = false,
    gridDivisions = 25
  }
)

Config.combo = ComboZone:Create({road1, road2}, {name = "Booths", debugPoly = false, lazyGrid = true})
