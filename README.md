# pov-ray
- marching_cube.f90

  - マーチングキューブ法により，物理量の等値面を取得するプログラムです(並列化なし)

  - 直交格子なら多分簡単にできます．（等間隔じゃなくてもできます）

  - 読み込んでいる物理量のファイルは，たとえば

    ```fortran
            double precision :: phi(nx_min:nx_max, ny_min:ny_max, nz_min:nz_max) ! phi: order parameter
            write(filename5,"(a,a,a)") trim(output_dire),trim(output_next),"phi.d"
            open(90,file=filename5,form="unformatted",status="replace")
            write(90) phi
            close(90)
    ```

    のように出力したバイナリ形式のファイルです．

  - ここでは，`0020000_phi.d`を読み込んで`0020000_isosurface_phi.d`と`0000001to0020000phi_isosurface_num_points.d`を出力しています．

  - `0000001to0020000phi_isosurface_num_points.d`はポリゴンデータの頂点の数を出力したファイルです．

    

- mk_pov.f90

  - marching_cube.f90で出力した等値面データのファイルを読み込んで.povファイルを作るプログラムです．
  - カメラの位置，見ている点，光源，容器などを自分で設定しています．
  - 等値面データはunionをつかって繋げていますが，他に方法はありそうです．
  - フォトンを使えばより現実的な画像が作れそうです．

- march.sh

  - マーチングキューブのプログラムを実行するスクリプト

- mkpov.sh

  - .povファイルを作って，povrayでレンダリングして画像を作るスクリプト
