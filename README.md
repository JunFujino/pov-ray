# pov-ray

### コードの説明



- **marching_cube_prof_goto_made.f90**

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

  - 実は，pov-rayでも物理量を読み込んで等値面を可視化出来るみたいですが．．．

    

- **mk_pov.f90**

  - marching_cube_goto_made.f90で出力した等値面データのファイルを読み込んで.povファイルを作るプログラムです．
  - カメラの位置，見ている点，光源，容器などを自分で設定しています．
  - 等値面データはunionをつかって繋げていますが，他に方法はありそうです．
  - フォトンを使えばより現実的な画像が作れそうです．

- **march.sh**

  - マーチングキューブのプログラムを実行するスクリプト

- **mkpov.sh**

  - .povファイルを作って，povrayでレンダリングして画像を作るスクリプト

- **0020000_isosurface_phi.pov**
  - .povファイルです．プログラムみたいな感じです．
  - vtkファイルみたいなノリでfortranで書いています．

### 参考にしたもの

- POV-Rayによる3次元CG制作/鈴木広隆・倉田和夫・佐藤尚
- [POV-Ray 初心者向けチュートリアル & Tips - asahi net](http://www.asahi-net.or.jp/~va5n-okmt/pov/tutorial/index.html)
- [POV-JP-HTML-Manual-3.5](https://flex.phys.tohoku.ac.jp/texi/pov35jp/pov35ref.html)

  などです．