#! /usr/bin/env python3

import urllib.request
import json
import time
import matplotlib.pylab

api_url = 'https://www.bitstamp.net/api/'
ticker_url = api_url + 'ticker'

def main():
    auth_handler = urllib.request.HTTPBasicAuthHandler()
    auth_handler.add_password(
            realm='BitStamp API',
            uri=api_url,
            user='kramar42',
            passwd='_zec42forever_')

    opener = urllib.request.build_opener(auth_handler)
    urllib.request.install_opener(opener)

    #t = int(time.time())
    t = 0
    times = [t]

    values = []
    values.append(open_url(ticker_url)['last'])

    fig, ax = matplotlib.pylab.subplots(1, 1)

    #ax.set_aspect('equal')
    ax.set_xlim(0, 100)
    ax.set_ylim(790, 890)

    ax.hold(True)
    fig.canvas.draw()
    fig.show()
    #backgroujnd = fig.canvas.copy_from_bbox(ax.bbox)
    plt = ax.plot(times, values, 'o')[0]
    
    #print('%f - %s' % (time.time(), values[-1]))
    while True:
        time.sleep(1)
        t = t + 1
        times.append(t)
        values.append(open_url(ticker_url)['last'])

        plt.set_data(times, values)
        #fig.canvas.restore_region(background)
        #ax.draw_artist(plt)
        #fig.canvas.blit(ax.bbox)

        fig.canvas.draw()


def open_url(url):
    handler = urllib.request.urlopen(url)
    return json.loads(handler.readall().decode('unicode_escape'))

if __name__ == '__main__':
    main()

