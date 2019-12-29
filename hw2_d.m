% Calculate probability of error
GroundTruth=im2double(imread('cheetah_mask.bmp'));
Mask=(reshape(StateV_Y,270,255)).';
N_FG_Pixels=0;
N_BG_Pixels=0;
FG_misc=0;
BG_misc=0;
for i=1:255
    for j=1:270
       if GroundTruth(i,j)==1
           N_FG_Pixels = N_FG_Pixels+1;
           if Mask(i,j)==0
               FG_misc=FG_misc+1;
           end
       elseif GroundTruth(i,j)==0
           N_BG_Pixels=N_BG_Pixels+1;
           if Mask(i,j)==1
               BG_misc=BG_misc+1;
           end
       end
    end
end
p_FG_error=FG_misc/N_FG_Pixels*Prior_cheetah
p_FG_error1=FG_misc/(N_FG_Pixels+N_BG_Pixels);
p_BG_error=BG_misc/N_BG_Pixels*Prior_grass
p_BG_error1=BG_misc/(N_FG_Pixels+N_BG_Pixels);
PoE=p_FG_error+p_BG_error
