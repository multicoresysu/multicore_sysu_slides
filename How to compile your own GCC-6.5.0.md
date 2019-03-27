## 非Root用户下编译GCC 6.5.0

1. **下载gcc-6.5.0**

   建议先到网站上下载，然后再通过jupyter上传到服务器。

   ```bash
   wget https://ftp.gnu.org/gnu/gcc/gcc-6.5.0/gcc-6.5.0.tar.gz
   ```

2. **解压gcc**

   ```bash
   tar zxvf gcc-6.5.0.tar.gz
   cd gcc-6.5.0
   ```

3. **安装依赖文件**

   ```bash
   ./contrib/download_prerequisites
   ```

4. **创建编译目录**

   ```bash
   cd ..
   
   mkdir gcc-6.5.0-build
   cd gcc-6.5.0-build
   ```

5. **配置并编译**

   ```bash
   ../gcc-6.5.0/configure --disable-checking --enable-languages=c,c++ --disable-multilib --prefix=/home/jovyan/gcc6 --enable-threads=posix
   
   make -j32 && make install
   ```

6. **查看是否安装成功**

   ```bash
   cd	# /home/jovyan/
   ./gcc6/bin/gcc -v		# 6.5.0
   ```

7. **设置环境变量**

   ```bash
   touch bashrc
   
   # Edit "bashrc" in jupyter, you can't use vi or vim via Terminal
   # Add following lines into "bashrc" and save (you can also specify your own gcc path):
   export PATH="/home/jovyan/gcc6/bin:/home/jovyan/gcc6/lib64:$PATH"
   export LD_LIBRARY_PATH="/home/jovyan/gcc6/lib:$LD_LIBRARY_PATH"
   
   # In Terminal
   mv bashrc .bashrc
   source .bashrc
   
   # Check if it works
   gcc -v	# 6.5.0
   ```

   