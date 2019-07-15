## 验证脚本

- 把所有的验证脚本放到作业文件夹的上一级目录，如下：
  - scripts
  - 1633xxxx-name
    - sources

```shell
gcc generate.c -o generate
gcc judge.c -o judge
chmod +x homework.sh
bash homework.sh
python judge.py
```

- 结果保存在report.csv文件中，第二列为正确性，第三列为时间。