-- usage

--usage for png
--local PNG = require(path.to.png_luau)
--local miniMagick = require(path.to.miniMagick)

-- Usage after you have PNG bytes (from HttpService, ModuleScript):
-- local img = miniMagick.fromPNG(pngBytes)

local miniMagick = require(path.To.miniMagick)

-- Create a 3x3 red image
local image = miniMagick.new(3, 3, {
    R = 255,
    G = 0,
    B = 0,
})

-- Apply transformations
miniMagick.grayscale(image)
miniMagick.brightness(image, 1.5)
miniMagick.invert(image)

-- Read a pixel
local pixel = miniMagick.getPixel(image, 1, 1)

if pixel then
    print(pixel.R, pixel.G, pixel.B)
end
