classdef Materials
    properties(Constant)
        Rogers4350 = struct('permittivity', 3.66, ...
                            'color', [200 200 200]./256)
        ArlonCuClad6250 = struct('thickness', 38e-6, ...
                                 'permittivity', 2.32, ...
                                 'color', [225 220 50]./256)
        DupontPyraluxAP = struct('thickness', 25.4e-6, ...
                                 'permittivity', 3.4, ...
                                 'color', [225 50 50]./256)
        Rohacell31HF = struct('permittivity', 1.045, ...
                              'color', [200 200 200]./256)
        Rohacell51HF = struct('permittivity', 1.065, ...
                              'color', [200 200 200]./256)
        Rohacell71HF = struct('permittivity', 1.093, ...
                              'color', [200 200 200]./256)
        Rogers6002 = struct('permittivity', 2.94, ...
                            'color', [50 50 50]./256);
        Rogers5880 = struct('permittivity', 2.2, ...
                            'color', [50 50 50]./256);
        QuartzEpoxy = struct('thickness', 0.8e-3, ...
                             'permittivity', 3.3, ...
                             'color', [255, 100, 0]./256);
                        
        Superstrate = Materials.QuartzEpoxy
        Substrate = Materials.Rogers5880
        ADLSubstrate = Materials.DupontPyraluxAP
        Glue = Materials.ArlonCuClad6250
        Foam = Materials.Rohacell31HF
    end
    methods(Static)
        function BuildCST(project)
            material = project.Material();
            materialnames = properties(Materials);
            for(i = 1:length(materialnames))
                mat = Materials.(materialnames{i});
                name = num2str(mat.permittivity, 5);
                material.Reset();
                material.Name(name);
                material.Folder('Generated');
                material.Colour(mat.color(1), mat.color(2), mat.color(3));
                material.Epsilon(mat.permittivity);
                
                % Permittivity, can be anisotropic.
                if(isstruct(mat.permittivity))
                    material.EpsilonX(mat.permittivity.x);
                    material.EpsilonY(mat.permittivity.y);
                    material.EpsilonZ(mat.permittivity.z);
                elseif(length(mat.permittivity) > 1)
                    material.EpsilonX(mat.permittivity(1));
                    material.EpsilonY(mat.permittivity(2));
                    material.EpsilonZ(mat.permittivity(3));
                else
                    material.Epsilon(mat.permittivity);
                end
                % Permeability, can be anisotropic. Default 1.
                if(isfield(mat, 'permeability'))
                    if(isstruct(mat.permeability))
                        material.MuX(mat.permeability.x);
                        material.MuY(mat.permeability.y);
                        material.MuZ(mat.permeability.z);
                    elseif(length(mat.permeability) > 1)
                        material.MuX(mat.permeability(1));
                        material.MuY(mat.permeability(2));
                        material.MuZ(mat.permeability(3));
                    else
                        material.Mu(mat.permeability);
                    end
                else
                    material.Mu(1);
                end
                
                material.Transparency(0.5);
                material.Create();
            end
        end
    end
end