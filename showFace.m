function [ output_args ] = showFace( face )
%SHOWFACE shows the image corresponding to a face vector
%   Wrapper function for ease of use when printing out faces. Input is a
%   vector 2576x1 or 1x2576


if size(face,1)~=2576 && size(face,2)~=2576
    disp('wrong face vector size');
    return;
elseif size(face,1)==2576
    face=reshape(face,56,46);   
    imshow(mat2gray(face));
elseif size(face,2)==2576
    face=reshape(face',56,46);
    imshow(mat2gray(face));
   
end

