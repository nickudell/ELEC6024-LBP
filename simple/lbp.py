#! /usr/bin/python
import cv, random, matplotlib.pyplot as plt, numpy as np, pickle, argparse

def rotate(im, angle):
	centre = ((im.width-1)/2.0, (im.height-1)/2.0)
	rot = cv.CreateMat(2, 3, cv.CV_32FC1)
	cv.GetRotationMatrix2D(centre, angle, 1.0, rot)
	dst = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
	cv.WarpAffine(im, dst, rot)
	return dst
	
def contrast(im, value):
	im = np.asarray(im, dtype = float)
	im *= args.contrast
	im = np.clip(im, 0, 255)
	im = im.astype('uint8')
	im = cv.fromarray(im)
	return im

parser = argparse.ArgumentParser(description = 'Simple implementation of LBP texture recognition.')
parser.add_argument('imagename', nargs = 1, help = 'Texture to load.')
parser.add_argument('--hist', dest = 'show_hist', action = 'store_true', help = 'Display histogram output.')
parser.add_argument('--rotate', nargs = '?', metavar = 'int', dest = 'rotate', type = int, default = 0, help = 'Rotate image and take samples from close to centre.')
parser.add_argument('--sample', nargs = '?', metavar = 'int', dest = 'sample', type = int, default = 32, help = 'Dimension of the texture sample.')
parser.add_argument('--contrast', nargs = '?', metavar = 'float', dest = 'contrast', type = float, default = 1, help = 'Alter contrast of input image')
args = parser.parse_args()

input = args.imagename[0]

im = cv.LoadImageM(input + '.tiff', cv.CV_LOAD_IMAGE_UNCHANGED)

if im.channels != 1:
	grey = cv.CreateMat(im.height, im.width, cv.CV_8UC1)
	cv.CvtColor(im, grey, cv.CV_RGB2GRAY)
	im = grey
	
if args.contrast != 1:
	im = contrast(im, args.contrast)

def check_sample(max_dim):
	if args.sample >= max_dim:
		print 'Sample too big.  Defaulting to 32x32'
		args.sample = 32
		
wscale = 500.0/im.width
hscale = 500.0/im.height

if args.rotate != 0:
	im = rotate(im, args.rotate)
	angle = args.rotate
	angle = (angle/360.0)*2*np.pi
	centre = ((im.width-1)/2, (im.height-1)/2)
	w = float(im.width)
	h = float(im.height)
	width = w/(np.abs(np.sin(angle))*(h/w + np.abs((np.cos(angle)/np.sin(angle)))))
	height = (w/h)*width
	max_dim = width if width > height else height
	check_sample(max_dim)
	pt1 = (centre[0]-int(width/2), centre[1]-int(height/2))
	pt2 = (centre[0]+int(width/2)-1, centre[1]+int(height/2)-1)
	cv.Rectangle(im, pt1, pt2, 255)
	pos = (random.randint(pt1[0], pt2[0]-args.sample), 
		   random.randint(pt1[0], pt2[0]-args.sample))
		
	resize = cv.CreateMat(500, 500, cv.CV_8UC1)
	cv.Resize(im, resize)
	w = int(pos[0]*wscale)
	h = int(pos[1]*hscale)
	cv.Rectangle(resize, (w,h), (w+int(args.sample*wscale), h+int(args.sample*wscale)), 255, 2)
	
	cv.NamedWindow('Rotated Texture Sample')
	cv.ShowImage('Rotated Texture Sample', resize)

else:
	max_dim = im.width if im.width > im.height else im.height
	check_sample(max_dim)
		
	pos = (random.randint(0, im.height-1-args.sample), random.randint(0, im.width-1-args.sample))
	resize = cv.CreateMat(500, 500, cv.CV_8UC1)
	cv.Resize(im, resize)
	w = int(pos[0]*wscale)
	h = int(pos[1]*hscale)
	cv.Rectangle(resize, (w,h), (w+int(args.sample*wscale), h+int(args.sample*hscale)), 255, 2)
	
	cv.NamedWindow('Texture Sample')
	cv.ShowImage('Texture Sample', resize)	

im = cv.GetSubRect(im, pos + (args.sample, args.sample))
sub = cv.CreateMat(args.sample+2,args.sample+2, cv.CV_8UC1)
cv.CopyMakeBorder(im, sub, (1,1), 0)

scores = []
contrasts = []

for row in range(1,args.sample+1):
	for col in range(1,args.sample+1):
		con1, con0 = 0, 0
		con1_l, con0_l = 0,0
		threshold = sub[row,col]
		score = 0
		if sub[row-1, col-1] >= threshold:
			score += 1
			con1 += sub[row-1, col-1]
			con1_l += 1
		else:
			con0 += sub[row-1, col-1]
			con0_l += 1
		if sub[row-1, col] >= threshold:
			score += 2
			con1 += sub[row-1, col]
			con1_l += 1
		else:
			con0 += sub[row-1, col]
			con0_l += 1
		if sub[row-1, col+1] >= threshold:
			score += 4
			con1 += sub[row-1, col+1]
			con1_l += 1
		else:
			con0 += sub[row-1, col+1]
			con0_l += 1
		if sub[row, col-1] >= threshold:
			score += 8
			con1 += sub[row, col-1]
			con1_l += 1
		else:
			con0 += sub[row, col-1]
			con0_l += 1
		if sub[row, col+1] >= threshold:
			score += 16
			con1 += sub[row, col+1]
			con1_l += 1
		else:
			con0 += sub[row, col+1]
			con0_l += 1
		if sub[row+1, col-1] >= threshold:
			score += 32
			con1 += sub[row+1, col-1]
			con1_l += 1
		else:
			con0 += sub[row+1, col-1]
			con0_l += 1
		if sub[row+1, col] >= threshold:
			score += 64
			con1 += sub[row+1, col]
			con1_l += 1
		else:
			con0 += sub[row+1, col]
			con0_l += 1
		if sub[row+1, col+1] >= threshold:
			score += 128
			con1 += sub[row+1, col+1]
			con1_l += 1
		else:
			con0 += sub[row+1, col+1]
			con0_l += 1
		try:
			ave1 = con1/con1_l
		except ZeroDivisionError:
			ave1 = 0
		try:
			ave0 = con0/con0_l
		except ZeroDivisionError:
			ave0 = 0
		contrasts.append(ave1 - ave0)
		scores.append(score)
		
contrast_hist = np.histogram(contrasts, 32)[0]
contrast_hist[contrast_hist<=0] = 1
lbp_hist = np.histogram(scores, 32)[0]
lbp_hist[lbp_hist<=0] = 1

contrast_norm = []
for i in contrast_hist:
	contrast_norm.append(i/float(sum(contrast_hist)))
lbp_norm = []
for i in lbp_hist:
	lbp_norm.append(i/float(sum(lbp_hist)))

wool = open('./Models/wool_model', 'r')
straw = open('./Models/straw_model', 'r')
grass = open('./Models/grass_model', 'r')
bark = open('./Models/bark_model', 'r')

wool_model = pickle.load(wool)
straw_model = pickle.load(straw)
grass_model = pickle.load(grass)
bark_model = pickle.load(bark)

wool.close()
straw.close()
grass.close()
bark.close()

wool_score = 0
for i in range(32):
	wool_score += lbp_norm[i]*np.log(lbp_norm[i]/wool_model[i])
straw_score = 0
for i in range(32):
	straw_score += lbp_norm[i]*np.log(lbp_norm[i]/straw_model[i])
grass_score = 0
for i in range(32):
	grass_score += lbp_norm[i]*np.log(lbp_norm[i]/grass_model[i])
bark_score = 0
for i in range(32):
	bark_score += lbp_norm[i]*np.log(lbp_norm[i]/bark_model[i])
	
print 'Grass: '  + str(1./grass_score)
print 'Wool: ' + str(1/wool_score)
print 'Straw: '  + str(1/straw_score)
print 'Bark: '  + str(1/bark_score)

if args.show_hist:
	plt.hist(scores, 32)
	plt.title(input.title() + ' ' + str(pos))
	plt.xlim(0,255)
	# plt.savefig('./Figures/'+input+str(pos))
	plt.show()
else:
	cv.WaitKey(0)

# 
# plt.clf()
# plt.hist(contrasts, 32)
# plt.title(input.title() + ' ' + str(pos) + ' contrast measure')
# plt.savefig('./Figures/'+input+str(pos)+'contrast')

# plt.show()