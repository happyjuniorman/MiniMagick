
-- MiniMagick
-- A simple ImageMagick inspired library for roblox

local MiniMagick = {}

export type Color = {
    R: number,
    G: number,
    B: number,
}

export type Image = {
    Width: number,
    Height: number,
    Pixels: {{Color}},
}

local function clamp(value: number): number
    return math.clamp(math.floor(value + 0.5), 0, 255)
end

function MiniMagick.new(width: number, height: number, color: Color?): Image
    local pixels = {}

    for y = 1, height do
        pixels[y] = {}

        for x = 1, width do
            local c = color or { R = 0, G = 0, B = 0 }

            pixels[y][x] = {
                R = c.R,
                G = c.G,
                B = c.B,
            }
        end
    end

    return {
        Width = width,
        Height = height,
        Pixels = pixels,
    }
end

function MiniMagick.grayscale(image: Image): Image
    for y = 1, image.Height do
        for x = 1, image.Width do
            local p = image.Pixels[y][x]
            local gray = clamp(
                p.R * 0.299 +
                p.G * 0.587 +
                p.B * 0.114
            )

            p.R = gray
            p.G = gray
            p.B = gray
        end
    end

    return image
end

function MiniMagick.invert(image: Image): Image
    for y = 1, image.Height do
        for x = 1, image.Width do
            local p = image.Pixels[y][x]

            p.R = 255 - p.R
            p.G = 255 - p.G
            p.B = 255 - p.B
        end
    end

    return image
end

function MiniMagick.brightness(
    image: Image,
    amount: number
): Image
    -- amount: 1.0 = unchanged, 1.5 = brighter
    for y = 1, image.Height do
        for x = 1, image.Width do
            local p = image.Pixels[y][x]

            p.R = clamp(p.R * amount)
            p.G = clamp(p.G * amount)
            p.B = clamp(p.B * amount)
        end
    end

    return image
end

function MiniMagick.threshold(
    image: Image,
    level: number
): Image
    for y = 1, image.Height do
        for x = 1, image.Width do
            local p = image.Pixels[y][x]
            local gray = p.R * 0.299
                + p.G * 0.587
                + p.B * 0.114

            local value = if gray >= level then 255 else 0

            p.R = value
            p.G = value
            p.B = value
        end
    end

    return image
end

function MiniMagick.flipHorizontal(image: Image): Image
    for y = 1, image.Height do
        for x = 1, math.floor(image.Width / 2) do
            local opposite = image.Width - x + 1

            image.Pixels[y][x],
            image.Pixels[y][opposite] =
                image.Pixels[y][opposite],
                image.Pixels[y][x]
        end
    end

    return image
end

function MiniMagick.flipVertical(image: Image): Image
    for y = 1, math.floor(image.Height / 2) do
        local opposite = image.Height - y + 1

        image.Pixels[y], image.Pixels[opposite] =
            image.Pixels[opposite], image.Pixels[y]
    end

    return image
end

function MiniMagick.getPixel(
    image: Image,
    x: number,
    y: number
): Color?
    if x < 1 or x > image.Width
        or y < 1 or y > image.Height then
        return nil
    end

    return image.Pixels[y][x]
end

function MiniMagick.setPixel(
    image: Image,
    x: number,
    y: number,
    color: Color
): boolean
    if x < 1 or x > image.Width
        or y < 1 or y > image.Height then
        return false
    end

    image.Pixels[y][x] = {
        R = clamp(color.R),
        G = clamp(color.G),
        B = clamp(color.B),
    }

    return true
end

return MiniMagick
