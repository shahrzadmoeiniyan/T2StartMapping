function T2sMap=T2sfit(baseFilename,z_Range,TEarr,outfname)

    fnames=dir(baseFilename);
    niiInfo=spm_vol(fnames(1).name); %NOTE: assuming that all images have the same matrix size
    
    teNum=length(fnames);  %number of TEs
    teImgs=zeros(niiInfo.dim(1),niiInfo.dim(2),niiInfo.dim(3),teNum);   %a 4D matrix to keep T2star intensities of all echo images
    T2sMap=zeros(niiInfo.dim(1),niiInfo.dim(2),niiInfo.dim(3));
    
    for teIdx=1:teNum
        currInfo=spm_vol(fnames(teIdx).name);
        teImgs(:,:,:,teIdx)=spm_read_vols(currInfo);
    end
    
    
    opts = fitoptions('Method','NonlinearLeastSquares','Lower',[0, 1, -Inf],'Upper',[100, 300, Inf], 'Startpoint', [0.5 30 0] ,'DiffMinChange',1.0e-4,'DiffMaxChange',0.1,'MaxIter',1000');
    ftype = fittype('m0 * exp(-TEarr ./ T2s) + c','dependent',{'s'},'independent',{'TEarr'},'coefficients',{'m0','T2s','c'});
                   
    for z=z_Range      %1:niiInfo.dim(3)
        for x = 1:niiInfo.dim(1)
            for y = 1:niiInfo.dim(2)         
               s=squeeze(teImgs(x,y,z,:));
               if max(s) ~= 0
                   s=s / max(s);
                   fitobj = fit(TEarr',s,ftype,opts);
                   T2s=fitobj.T2s;
                   T2sMap(x,y,z)=T2s;
               end
            end
        end
        z
        save(outfname,'T2sMap');
    end
    
    %save(outfname,'T2sMap');
end