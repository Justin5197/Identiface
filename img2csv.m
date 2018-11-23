% Creates a variable for the image folder
myDir = 'imgs';
% Checks that given image folder exists. Gives error message if not found.
if ~isfolder(myDir)
  errorMsg = sprintf('Error: Directory not found:\n%s', myDir);
  uiwait(warndlg(errorMsg));
  return;
end

% Gets list of all files with the corresponding file extension
f = fullfile(myDir, '*.jpg');
theFiles = dir(f);
vector_img = zeros(28^2, length(theFiles ));
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName); %prints the current image being processed.
  img = imread(fullFileName); %reads image
  img_gray = rgb2gray(img); %turns image to grayscale
  img_28 = imresize(img_gray, [28 28]); %resizes image
  vector_img(:,k) = img_28(:); %vectorizes the image
end

csvwrite('imgdata.csv', vector_img, 1); %writes the vectorized images to csv file