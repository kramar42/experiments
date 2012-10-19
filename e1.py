
import media


def main():
    f = media.choose_file()
    pic = media.load_picture(f)
    #color = media.choose_color()
    moderate_blue(pic).show_external()


def same_dimensions(pic1, pic2):
    return pic1.get_height() == pic2.get_height() and \
           pic1.get_width() == pic2.get_width()


def copyright():
    # create black and white colors
    black = media.create_color(0, 0, 0)
    white = media.create_color(255, 255, 255)
    # create empty picture
    pic = media.create_picture(20, 20, white)
    # add oval
    media.add_oval(pic, 0, 0, 16, 16, black)
    # add symbol
    media.add_text(pic, 6, 3, "C", black)

    return pic


def moderate_blue(pic):
    # copy picture
    pic = pic.copy()
    # moderate each pixel in picture
    for pixel in media.get_pixels(pic):
        # calc average
        average = (pixel.get_green() + pixel.get_red()) / 2
        # change blue value of pixel
        pixel.set_blue(average)
    return pic

main()
