array=["xxx-x---x-xxx---","x---x---x-x-x---","x---x---x-xxxxxx","x---xxx-x----x--","x---x-x-x----xx-","x---x-x-x----x--","xxx-x-x-x----xxx"]
for y in range(0,len(array)):
    for x in range(0,len((array[y])):
        if array[y][x] == 'x':
            picounicorn.set_pixel(x,y,255,255,255)
        else:
            picounicorn.set_pixel(x, y, 0,0,0)
