import cv, pickle, numpy as np, matplotlib.pyplot as plt

input = 'bark'

im = cv.LoadImageM(input + '.tiff', cv.CV_LOAD_IMAGE_UNCHANGED)
sub = cv.CreateMat(im.height+2, im.width+2, cv.CV_8UC1)
cv.CopyMakeBorder(im, sub, (1,1), 0)

scores = []
contrasts = []

for row in range(1,sub.height-1):
	print row
	for col in range(1,sub.width-1):
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

# print lbp_norm
# exit()
# plt.hist(scores, 32, normed = True)
# plt.xlim(0,255)
# plt.title(input.title()+' texture spectrum')
# plt.show()
# exit()
	
file_c = open('./Models/' +input+'_model_c', 'w')
file = open('./Models/' + input+'_model', 'w')

pickle.dump(contrast_norm, file_c)
pickle.dump(lbp_norm, file)

file_c.close()
file.close()