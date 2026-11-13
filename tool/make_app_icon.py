import os

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FREDOKA = os.path.join(ROOT, "assets", "fonts", "Fredoka.ttf")
OUT = os.path.join(ROOT, "assets", "icon")

PINK = (242, 124, 160)
PINK_LIGHT = (249, 168, 192)
VIOLET = (109, 40, 217)
VIOLET_SOFT = (139, 92, 246)
YELLOW = (255, 214, 10)
WHITE = (255, 255, 255)


def font(size):
    return ImageFont.truetype(FREDOKA, size)


def gradient(size, c1, c2):
    ys, xs = np.mgrid[0:size, 0:size]
    t = (xs + ys) / (2 * size)
    arr = np.zeros((size, size, 4), dtype=np.uint8)
    for i in range(3):
        arr[..., i] = (t * c1[i] + (1 - t) * c2[i]).astype(np.uint8)
    arr[..., 3] = 255
    return Image.fromarray(arr, "RGBA")


def star_burst(size, color, points=12, inner=0.58):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    cx = cy = size / 2
    outer = size * 0.5
    path = []
    for i in range(points * 2):
        ang = -np.pi / 2 + i * np.pi / points
        r = outer if i % 2 == 0 else outer * inner
        path.append((cx + r * np.cos(ang), cy + r * np.sin(ang)))
    d.polygon(path, fill=color)
    return img


def sparkle(size, color):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    cx = cy = size / 2
    outer = size / 2
    inner = size * 0.16
    path = []
    for i in range(8):
        ang = -np.pi / 2 + i * np.pi / 4
        r = outer if i % 2 == 0 else inner
        path.append((cx + r * np.cos(ang), cy + r * np.sin(ang)))
    d.polygon(path, fill=color)
    return img


def letter_c(size, color, fsize):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.text((size / 2, size / 2), "C", font=font(fsize), fill=color, anchor="mm")
    return img


def compose_icon(size=1024, rounded=False):
    img = gradient(size, PINK, VIOLET)
    burst = star_burst(int(size * 0.92), WHITE + (46,))
    img.alpha_composite(burst, (int(size * 0.04), int(size * 0.04)))
    c_layer = letter_c(size, WHITE + (255,), int(size * 0.62))
    glow = c_layer.filter(ImageFilter.GaussianBlur(size * 0.012))
    img.alpha_composite(glow)
    img.alpha_composite(c_layer)
    spark = sparkle(int(size * 0.15), YELLOW + (255,))
    img.alpha_composite(spark, (int(size * 0.7), int(size * 0.13)))
    if rounded:
        mask = Image.new("L", (size, size), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            [0, 0, size - 1, size - 1], radius=int(size * 0.23), fill=255
        )
        img.putalpha(mask)
    return img


def compose_foreground(size=1024):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    zone = int(size * 0.62)
    offset = int((size - zone) / 2)
    burst = star_burst(zone, WHITE + (46,))
    img.alpha_composite(burst, (offset, offset))
    c_size = zone
    c_layer = letter_c(c_size, WHITE + (255,), int(zone * 0.66))
    img.alpha_composite(c_layer, (offset, offset))
    spark = sparkle(int(size * 0.1), YELLOW + (255,))
    img.alpha_composite(spark, (int(size * 0.66), int(size * 0.2)))
    return img


def compose_splash(width=900):
    height = int(width * 0.62)
    img = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    badge = compose_icon(420, rounded=True)
    img.alpha_composite(badge, (int((width - 420) / 2), 10))
    d = ImageDraw.Draw(img)
    d.text(
        (width / 2, height * 0.82),
        "CHARADES",
        font=font(120),
        fill=WHITE + (255,),
        anchor="mm",
    )
    return img


def main():
    os.makedirs(OUT, exist_ok=True)
    compose_icon(1024).save(os.path.join(OUT, "app_icon.png"))
    compose_foreground(1024).save(os.path.join(OUT, "app_icon_foreground.png"))
    compose_splash(900).save(os.path.join(OUT, "splash_logo.png"))
    print("wrote app_icon.png, app_icon_foreground.png, splash_logo.png")


if __name__ == "__main__":
    main()
