-- usage

local MiniMagick = require(path.To.MiniMagick)

-- Create a 3x3 red image
local image = MiniMagick.new(3, 3, {
    R = 255,
    G = 0,
    B = 0,
})

-- Apply transformations
MiniMagick.grayscale(image)
MiniMagick.brightness(image, 1.5)
MiniMagick.invert(image)

-- Read a pixel
local pixel = MiniMagick.getPixel(image, 1, 1)

if pixel then
    print(pixel.R, pixel.G, pixel.B)
end
