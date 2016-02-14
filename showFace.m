function [ output_args ] = showFace( face )
%SHOWFACE shows the image corresponding to a face vector
%   Wrapper function for ease of use when printing out faces

if size(face,1)==2756
    face=reshape(face,56,46);
else
    face=reshape(face',56,46);
imshow(mat2gray(face));

end

