% loop gen barrier through shapes
for QW = 3%1:6
    for AA = 2%1:7
        for sl = 2
            sl
            for ndc = 1%:4
                ndc
                for shape_ = 3:3 % 1 small w, 2-4 bbay
                    if shape_ == 1
                        for mbw = 1:5
                            mbw
                            Geobarrier_main_loop_sl_shapes_ndc(mbw,sl,ndc,AA,QW,shape_) 
                        end
                    else
                        Geobarrier_main_loop_sl_shapes_ndc([],sl,ndc,AA,QW,shape_) 

                    end
                end
            end
        end
    end
end