
import media


def main():
    f = media.choose_file()
    pic = media.load_picture(f)
    color = media.choose_color()
    moderate_pic(pic, color, 10).show_external()


def moderate_pic(pic, color, delta):
    # copy picture
    pic = pic.copy()
    # moderate each pixel in picture
    for pixel in media.get_pixels(pic):
        if pixel.get_color().distance(color) > delta:
            av = (pixel.get_green() + pixel.get_red() + pixel.get_blue()) / 3
            # change colors in pixel
            pixel.set_blue(av)
            pixel.set_green(av)
            pixel.set_red(av)
    return pic


def average(color1, color2):
    return color1.distance(color2)
#((color1.get_red() - color2.get_red()) ** 2 + \
#          (color1.get_green() - color2.get_green()) ** 2 + \
#          (color1.get_blue() - color2.get_blue()) ** 2) ** 0.5

if __name__ == "__main__":
    main()
