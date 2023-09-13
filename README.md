# AvZ批量生成多个dll

## 问题

[AvZ多开工具](https://github.com/alumkal/avz-multi-instance-tools/tree/main)很好用，可是有时候我们希望从一个`.cpp`源码中生成多个`dll`（例如使用刷新测试器拆分测试项目时），然后一并注入。

## 先前的做法

你可能需要复制同一文件多次，修改每个文件的细节，然后依次手动编译每个（而且默认编译指令只会编译出`libavz.dll`，还得处理文件名冲突🙃）

## 有了本工具后

其实就是一个批处理文件，利用宏定义生成多个内容不同的`dll`文件。

依如下方式修改源码（以刷新测试器为例）：
```cpp
#include "refresh/refresh.h"

vector<Task> get_tasks() {
    vector<Task> tasks;
#ifdef P1
    tasks.push_back(TaskBuilder()
        .total("foo")
        // 后略
    );
#endif

#ifdef P2
    tasks.push_back(TaskBuilder()
        .prefix("bar")
        // 后略
    );
#endif
    return tasks;
}
```

并修改本项目提供的`create_multiple_dll.batch`文件中以下项目：
```batch
rem AvZ安装目录、源码文件名、子单元数
set "avz_dir=C:\Path\To\AsmVsZombies"
set "source=.\PE-activate.cpp"
set "subunit_num=2"
```

再运行之即可。

之后按照[AvZ多开工具](https://github.com/alumkal/avz-multi-instance-tools/tree/main)中的使用说明，将得到的所有`dll`一并拖入其提供的`injector.exe`即可。

## 附加说明

本工具只支持AvZ1.