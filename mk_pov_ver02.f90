program main
    implicit none
    !--------------------------------------------
    !   ファイル名
    !--------------------------------------------
    ! character(len=120), parameter :: iodire='/data/2019/fujino/lbm/stable_droplet/phi/'
    character(len=120), parameter :: iodire='./'
    character(len=120), parameter :: ifile='0020000_isosurface_phi.d'
    character(len=120), parameter :: ofile='0020000_isosurface_phi.pov'
    character(len=120), parameter :: ifile_point="0000001to0020000phi_isosurface_num_points.d"
    !--------------------------------------------
    !   定数と変数
    !--------------------------------------------
    integer, parameter :: num = 4
    integer :: point_num
    integer :: i
    real(kind=4), allocatable :: x(:)
    real(kind=4), allocatable :: y(:)
    real(kind=4), allocatable :: z(:)
    real(kind=4), allocatable :: gx(:)
    real(kind=4), allocatable :: gy(:)
    real(kind=4), allocatable :: gz(:)
    !--------------------------------------------
    !   定数と変数(Pov-ray用)
    !--------------------------------------------
    real(kind=4), parameter :: camera_x = 220.e0
    real(kind=4), parameter :: camera_y = 200.e0
    real(kind=4), parameter :: camera_z = -500.e0
    real(kind=4), parameter :: look_at_x = 48.e0
    real(kind=4), parameter :: look_at_y = 48.e0
    real(kind=4), parameter :: look_at_z = 48.e0
    real(kind=4), parameter :: angle = 0.e0
    real(kind=4), parameter :: light_source_x = -200.e0
    real(kind=4), parameter :: light_source_y = 5000.e0
    real(kind=4), parameter :: light_source_z = -2000.e0
    character(len=100), parameter :: mesh_smooth = 'smooth_triangle'
    character(len=100), parameter :: mesh_normal = 'triangle'
    logical, parameter :: smooth = .true.
    !--------------------------------------------
    !   定数と変数(Pov-rayの容器用)
    !--------------------------------------------
    real(kind=4), parameter :: cube_out_x = 48.e0
    real(kind=4), parameter :: cube_out_y = 48.e0
    real(kind=4), parameter :: cube_out_z = 48.e0
    real(kind=4), parameter :: cube_in_x = 48.e0
    real(kind=4), parameter :: cube_in_y = 50.e0
    real(kind=4), parameter :: cube_in_z = 48.e0
    real(kind=4), parameter :: cube_out_wid_x = 100.e0
    real(kind=4), parameter :: cube_out_wid_y = 102.e0
    real(kind=4), parameter :: cube_out_wid_z = 100.e0
    real(kind=4), parameter :: cube_in_wid_x = 96.e0
    real(kind=4), parameter :: cube_in_wid_y = 102.e0
    real(kind=4), parameter :: cube_in_wid_z = 96.e0
    real(kind=4), parameter :: cube_water_wid_x = 96.e0
    real(kind=4), parameter :: cube_water_wid_y = 96.e0
    real(kind=4), parameter :: cube_water_wid_z = 96.e0
    real(kind=4), parameter :: cube_water_x = 48.e0
    real(kind=4), parameter :: cube_water_y = 48.e0
    real(kind=4), parameter :: cube_water_z = 48.e0
    !--------------------------------------------
    !   ファイル用文字列
    !--------------------------------------------
    character(len=100) read_dataname
    character(len=100) read_dataname_point
    character(len=100) write_dataname
    character(len=100), parameter :: hdr_dataname ="""room.hdr"""
    !==============================================================================================
    !
    !   メインプログラム
    !
    !==============================================================================================
    !--------------------------------------------
    !   オープン
    !--------------------------------------------
    write(read_dataname,"(a,a)") trim(iodire),trim(ifile)
    write(read_dataname_point,"(a,a)") trim(iodire),trim(ifile_point)
    write(write_dataname,"(a,a)") trim(iodire),trim(ofile)
    open(10,file=read_dataname,status='old',action='read',form='unformatted')
    open(20,file=read_dataname_point,status='old',action='read',form='unformatted',access='direct',recl=4)
    open(21,file=write_dataname,form='formatted')
    !--------------------------------------------
    !   読み込み1
    !--------------------------------------------
    read(20, rec=num) point_num
    allocate(x(1:point_num),y(1:point_num),z(1:point_num),gx(1:point_num),gy(1:point_num),gz(1:point_num))
    close(20)
    !--------------------------------------------
    !   読み込み2
    !--------------------------------------------
    do i = 1, point_num
        read(10) x(i),y(i),z(i),gx(i),gy(i),gz(i)
    enddo
    !############################################
    !   書き込み
    !############################################
    !--------------------------------------------
    !   include
    !--------------------------------------------
    write(21,"(a)") "#include""colors.inc"""
    write(21,"(a)") "#include""textures.inc"""
    write(21,"(a)") "#include""shapes.inc"""
    !--------------------------------------------
    !   camera & look at
    !--------------------------------------------
    write(21,"(a)") " camera{"
    write(21,"(x,a,f8.2,a,f8.2,a,f8.2,a)") "location<",camera_x,",",camera_y,",",camera_z,">"
    write(21,"(x,a,f8.2,a,f8.2,a,f8.2,a)") "look_at<",look_at_x,",",look_at_y,",",look_at_z,">"
    write(21,"(x,a,f8.2,a,f8.2,a,f8.2,a)") "angle ",angle
    write(21,"(a)") "}"
    !--------------------------------------------
    !   light source
    !--------------------------------------------
    write(21,"(a,f9.2,a,f9.2,a,f9.2,a)") &
          "light_source{<",light_source_x,",",light_source_y,",",light_source_z,">color 1.1*White}"
    !--------------------------------------------
    !   plane
    !--------------------------------------------
    ! write(21,"(a)") "plane{ y,-48 pigment{checker color White color Gray  scale 100 } }"
    write(21,"(a)") "plane{ z,500 pigment{color White} }"
    write(21,"(a)") "plane{ y,-48 pigment{color White} }"
    ! write(21,"(a)") "plane{ <0,1,0>,0 pigment{checker color White color Gray  scale 40 } }"
    ! write(21,"(a)") "plane{ <0,1,0>,1 pigment{color White } }"
    ! write(21,"(a)") "plane{ <0,0,100>,-100 pigment{ color White } }"
    ! write(21,"(a)") "plane{ <0,1,0>,1 pigment{checker color White color Gray} }"
    !--------------------------------------------
    !   容器
    !--------------------------------------------
    write(21,"(a)") "difference{"
    write(21,"(a)") "object{"
    write(21,"(x,a)") "Cube"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "scale <", &
          cube_out_wid_x,",",cube_out_wid_y,",",cube_out_wid_z,">"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "translate <", &
          cube_out_x,",",cube_out_y,",",cube_out_z,">"
    write(21,"(x,a)") "material { M_Glass3 }"
    write(21,"(a)") "}"
    write(21,"(a)") "object{"
    write(21,"(x,a)") "Cube"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "scale <", &
          cube_in_wid_x,",",cube_in_wid_y,",",cube_in_wid_z,">"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "translate <", &
          cube_in_x,",",cube_in_y,",",cube_in_z,">"
    write(21,"(x,a)") " material{ M_Glass3 }"
    write(21,"(a)") "}"
    write(21,"(a)") "}"
    !--------------------------------------------
    !   水
    !--------------------------------------------
    write(21,"(a)") "object{"
    write(21,"(x,a)") "Cube"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "scale <", &
          cube_water_wid_x,",",cube_water_wid_y,",",cube_water_wid_z,">"
    write(21,"(x,a,f9.2,a,f9.2,a,f9.2,a)") "translate <", &
          cube_water_x,",",cube_water_y,",",cube_water_z,">"
    write(21,"(a)") "interior{ ior 1.33 caustics 0.7 }"
    write(21,"(a)") "pigment{ color White filter 0.7 }"
    write(21,"(a)") "finish { ambient 0.3 phong 0.6 }"
    write(21,"(a)") "}"
    !--------------------------------------------
    !   polygons
    !--------------------------------------------
    write(21,"(a)") "union{"
    if (smooth) then
        !-データ書き込み
        do i = 1, point_num, 3
            write(21,"(a,a,6(a,f0.10,a,f0.10,a,f0.10,a),a)") trim(mesh_smooth),"{ ", &
                  "<",x(i  ),",",y(i  ),",",z(i  ),">,","<",gx(i  ),",",gy(i  ),",",gz(i  ),">,", &
                  "<",x(i+1),",",y(i+1),",",z(i+1),">,","<",gx(i+1),",",gy(i+1),",",gz(i+1),">,", &
                  "<",x(i+2),",",y(i+2),",",z(i+2),">,","<",gx(i+2),",",gy(i+2),",",gz(i+2),"> ", &
                  "}"
        enddo
    else
        !-データ書き込み
        do i = 1, point_num, 3
            write(21,"(a,a,3(a,f0.10,a,f0.10,a,f0.10,a),a)") trim(mesh_normal),"{ ", &
                  "<",x(i  ),",",y(i  ),",",z(i  ),">,", &
                  "<",x(i+1),",",y(i+1),",",z(i+1),">,", &
                  "<",x(i+2),",",y(i+2),",",z(i+2),"> ", &
                  "}"
        enddo
    endif
    write(21,"(a)") "interior{ ior 1.4 caustics 0.7 }"
    write(21,"(a)") "pigment{ color White filter 0.7 }"
    write(21,"(a)") "finish { ambient 0.3 phong 0.6 }"
    write(21,"(a)") "}"
    !--------------------------------------------
    !   背景
    !--------------------------------------------
    ! write(21,"(a)") "sky_sphere{"
    ! write(21,"(x,a)") "pigment{"
    ! write(21,"(x,a)") "image_map{"
    ! write(21,"(x,x,a,a)") "hdr ",hdr_dataname
    ! write(21,"(x,x,a)") "map_type 1"
    ! write(21,"(x,x,a)") "interpolate 2"
    ! write(21,"(x,a)") "}"
    ! write(21,"(x,a)") "}"
    ! write(21,"(a)") "}"
    close(21)
    close(10)
end program main