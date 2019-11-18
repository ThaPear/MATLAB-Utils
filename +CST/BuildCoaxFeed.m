% dms = 0.254e-3;
% wms = 0.23e-3;
% lms = 1.5e-3;
% core_radius = 0.1e-3;
% core_tophole_radius = 0.1e-3;
% core_transition_radius = 0.05e-3;
% shield_radius = 0.1e-3;
% shield_distance = 0.5e-3;
% shield_startangle = ['90 - shield_totalangle/2'];
% shield_totalangle = 100;
% shield_Nvias = 3;
% cylinder_height = 0.916e-3;
% cylinder_Nvias = [];
% cylinder_angleoffset = 30;
% cylinder_connector_radius = shield_radius + 0.05e-3;
% project = CST.Application.Active3D();
% CST.BuildCoaxFeed_ViaCylinder(project, dms, wms, lms, ...
%                 core_radius, core_tophole_radius, core_transition_radius, ...
%                 shield_radius, shield_distance, shield_startangle, shield_totalangle, shield_Nvias, ...
%                 cylinder_height, cylinder_Nvias, cylinder_angleoffset, cylinder_connector_radius)


function BuildCoaxFeed(project, dms, wms, lms, ...
                core_radius, core_tophole_radius, core_transition_radius, ...
                shield_radius, shield_distance, shield_startangle, shield_totalangle, shield_Nvias)
    % It is assumed that the WCS is correctly positioned in the center of the feeding point on the
    % slot plane.
    % TODO: Implement cylinder_Nvias
    
    %% Create relevant parameters in the project.
    dmsname = 'dms';                            project.StoreParameter(dmsname, dms*1e3);
    wmsname = 'wms';                            project.StoreParameter(wmsname, wms*1e3);
    lmsname = 'lms';                            project.StoreParameter(lmsname, lms*1e3);
    rcorename = 'core_radius';                  project.StoreParameter(rcorename, core_radius*1e3);
    rtopholename = 'core_tophole_radius';       project.StoreParameter(rtopholename, core_tophole_radius*1e3);
    rcore2msname = 'core_transition_radius';    project.StoreParameter(rcore2msname, core_transition_radius*1e3);
    rshieldname = 'shield_radius';              project.StoreParameter(rshieldname, shield_radius*1e3);
    dshieldname = 'shield_distance';            project.StoreParameter(dshieldname, shield_distance*1e3);
    thstartname = 'shield_startangle';          project.StoreParameter(thstartname, shield_startangle);
    thtotalname = 'shield_totalangle';          project.StoreParameter(thtotalname, shield_totalangle);
    nvianame = 'shield_Nvias';                  project.StoreParameter(nvianame, shield_Nvias);
    % Parameters that should already exist.
    wfeedname = 'slot_feedwidth';
    lfeedname = 'slot_feedlength';
    hbackname = 'hback';
    % slot_s0
    % dx, dy
    
    arc = project.Arc();
    brick = project.Brick();
    component = project.Component();
    cylinder = project.Cylinder();
    tracefromcurve = project.TraceFromCurve();
    transform = project.Transform();
    wcs = project.WCS();
    
    %% Create microstrip
    % Microstrip itself
    brick.Reset();
    brick.Component('Feed/Xfeed');
    brick.Name('Test');
    brick.Material('PEC');
    brick.Xrange(['-', wmsname, '/2'], [wmsname, '/2']);
    brick.Yrange(['-', wfeedname, '/2 - ', lmsname], ['-', wfeedname, '/2']);
    brick.Zrange(['-', dmsname], ['-', dmsname]);
    brick.Create();
    
    % Create feed part
    brick.Reset();
    brick.Name('SlotFeed');
    brick.Component('Feed/Xfeed');
    brick.Material('PEC');
    brick.Xrange(['-0.8*', lfeedname, '/2'], ['0.8*', lfeedname, '/2']);
    brick.Yrange(['-', wfeedname, '/2'], [wfeedname, '/2']);
    brick.Zrange(['-', dmsname], ['-', dmsname]);
    brick.Create();
    
    %% Create short for the feed
    brick.Reset();
    brick.Name('Short');
    brick.Component('Feed/Xfeed');
    brick.Material('PEC');
    brick.Xrange(['-0.8*', lfeedname, '/2'], ['0.8*', lfeedname, '/2']);
    brick.Yrange([wfeedname, '/2'], [wfeedname, '/2']);
    brick.Zrange('-dms', '0');
    brick.Create();
    
    %% Create coax core
    cylinder.Reset();
    cylinder.Component('Feed/Xfeed');
    cylinder.Name('Core');
    cylinder.Material('PEC');
    cylinder.Axis('z');
    cylinder.Xcenter(0);
    cylinder.Ycenter(['-', wfeedname, '/2 - ', lmsname]);
    cylinder.Zrange(['-', hbackname], 0);
    cylinder.Innerradius(0);
    cylinder.Outerradius(rcorename);
    cylinder.Create();
    
    %% Create microstrip-to-core transition
    cylinder.Reset();
    cylinder.Component('Feed/Xfeed');
    cylinder.Name('Core2ms');
    cylinder.Material('PEC');
    cylinder.Axis('z');
    cylinder.Xcenter(0);
    cylinder.Ycenter(['-', wfeedname, '/2 - ', lmsname]);
    cylinder.Zrange(['-', dmsname], ['-', dmsname]);
    cylinder.Innerradius(0);
    cylinder.Outerradius([rcorename, ' + ', rcore2msname]);
    cylinder.Create();
    
    %% Create coax shield
    % Create first shield via
    cylinder.Reset();
    cylinder.Component('Feed/Xfeed');
    cylinder.Name('Shield');
    cylinder.Material('PEC');
    cylinder.Axis('z');
    cylinder.Xcenter(dshieldname);
    cylinder.Ycenter(['-', wfeedname, '/2 - ', lmsname]);
    cylinder.Zrange(['-', hbackname], 0);
    cylinder.Innerradius(0);
    cylinder.Outerradius(rshieldname);
    cylinder.Create();
    
    % Rotate shield via to shield start position
    transform.Reset();
    transform.Name('Feed/Xfeed:Shield');
    transform.Angle(0, 0, ['-', thstartname]);
    transform.Origin('Free');
    transform.Center(0, ['-', wfeedname, '/2 - ', lmsname], 0);
    transform.Repetitions(1);
    transform.MultipleObjects(0);
    transform.GroupObjects(0);
    transform.Transform('Shape', 'Rotate');
    
    % Copy shield via to form shield
    transform.Reset();
    transform.Name('Feed/Xfeed:Shield');
    transform.Angle(0, 0, ['-', thtotalname, ' / (', nvianame, ' - 1)']);
    transform.Origin('Free');
    transform.Center(0, ['-', wfeedname, '/2 - ', lmsname], 0);
    transform.Repetitions([nvianame, ' - 1']);
    transform.MultipleObjects(1);
    transform.GroupObjects(0);
    transform.Transform('Shape', 'Rotate');

    %% Create ground hole
    cylinder.Reset();
    cylinder.Name('GroundHole');
    cylinder.Component('Feed/Xfeed');
    cylinder.Material('PEC');
    cylinder.Outerradius([dshieldname, '-', rshieldname, '/2-0.1']);
    cylinder.Innerradius('0.0');
    cylinder.Axis('z');
    cylinder.Zrange(['-', hbackname], ['-', hbackname]);
    cylinder.Xcenter('0');
    cylinder.Ycenter(['-', wfeedname, '/2-', lmsname]);
    cylinder.Segments('0');
    cylinder.Create();

    %% Create top hole
    cylinder.Reset();
    cylinder.Name('TopHole');
    cylinder.Component('Feed/Xfeed');
    cylinder.Material('PEC');
    cylinder.Outerradius([rcorename, ' + ', rtopholename]);
    cylinder.Innerradius(rcorename);
    cylinder.Axis('z');
    cylinder.Zrange(0, 0);
    cylinder.Xcenter('0');
    cylinder.Ycenter(['-', wfeedname, '/2-', lmsname]);
    cylinder.Segments('0');
    cylinder.Create();


    %% Rotate X-feed by 90 to form the Y-feed
    wcs.Disable();
    component.New('Feed/Yfeed');
    transform.Reset();
    transform.Name('Feed/Xfeed');
    transform.Angle(0, 0, -90);
    transform.Origin('Free');
    transform.Center('(slot_s0-0.5)*dx', '(slot_s0-0.5)*dy', 0);
    transform.Repetitions(1);
    transform.MultipleObjects(1);
    transform.GroupObjects(0);
    transform.Destination('Feed/Yfeed');
    transform.Material('');
    transform.Transform('Shape', 'Rotate');
end