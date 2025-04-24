## SAPI

在 PHP 中，**SAPI（Server API）** 是指服务器应用程序接口（Server Application Programming Interface）。它是 PHP 与外部环境（如 Web 服务器或命令行）之间的通信接口。SAPI 的作用是让 PHP 能够在不同的运行环境中工作，比如通过 Web 服务器（如 Apache 或 Nginx）处理 HTTP 请求，或者通过命令行运行脚本。

### SAPI 的主要类型

PHP 支持多种 SAPI 类型，每种类型对应不同的运行环境和用途。以下是一些常见的 SAPI 类型：

#### 1. **CGI（Common Gateway Interface）**
   - **用途**：用于将 PHP 作为通用网关接口运行。
   - **特点**：每次 HTTP 请求都会启动一个新的 PHP 进程，处理完请求后进程结束。
   - **优点**：简单、轻量。
   - **缺点**：性能较低，因为每次请求都需要启动新进程。

#### 2. **FastCGI**
   - **用途**：用于提高 CGI 的性能。
   - **特点**：PHP 进程在处理完一个请求后不会立即退出，而是保持运行，等待下一个请求。
   - **优点**：性能优于 CGI，适合高并发场景。
   - **缺点**：需要配置 FastCGI 服务器（如 PHP-FPM）。

#### 3. **Apache 模块（mod_php）**
   - **用途**：将 PHP 作为 Apache Web 服务器的模块运行。
   - **特点**：PHP 直接嵌入到 Apache 中，每次 HTTP 请求都由 Apache 处理。
   - **优点**：性能高，配置简单。
   - **缺点**：与 Apache 紧密耦合，不适合与其他 Web 服务器（如 Nginx）配合使用。

#### 4. **Nginx 模块（php-fpm）**
   - **用途**：用于将 PHP 与 Nginx 配合使用。
   - **特点**：通过 PHP-FPM（FastCGI Process Manager）管理 PHP 进程。
   - **优点**：性能高，适合高并发场景。
   - **缺点**：需要额外配置 PHP-FPM。

#### 5. **命令行接口（CLI）**
   - **用途**：用于在命令行环境中运行 PHP 脚本。
   - **特点**：直接通过终端执行 PHP 脚本，不依赖 Web 服务器。
   - **优点**：适合执行后台任务、脚本自动化等。
   - **缺点**：无法处理 HTTP 请求。

#### 6. **嵌入式 SAPI（Embed）**
   - **用途**：将 PHP 嵌入到其他应用程序中。
   - **特点**：允许 PHP 代码在非 Web 环境中运行，例如嵌入到桌面应用程序或嵌入式系统中。
   - **优点**：灵活性高。
   - **缺点**：需要额外的开发工作。

#### 7. **其他 SAPI**
   - **ISAPI（Internet Server API）**：用于与 Microsoft 的 IIS（Internet Information Services）集成。
   - **LSAPI（LiteSpeed API）**：用于与 LiteSpeed Web 服务器集成。

### 总结
SAPI 是 PHP 与外部环境之间的桥梁，不同的 SAPI 类型适用于不同的运行环境和需求。选择合适的 SAPI 可以显著提升 PHP 的性能和灵活性。常见的 SAPI 类型包括 CGI、FastCGI、Apache 模块、Nginx 模块（php-fpm）、命令行接口（CLI）等。


https://cloud.tencent.com/developer/article/1181695
