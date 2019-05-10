
=== This is nginx for Windows, an event driven, non-blocking high performance full
featured webserver based on nginx.

SPDY, multiple workers, ASLR and DEP compliant, embedded WAF, embedded Lua are just
a few features to mention. ===


Note: Should you need support or report anything please use the nginx forums at
http://forum.nginx.org/ or post an issue at https://forums.ecsystems.nl/ or by email
support@ecsystems.nl (where we maintain the package builds)

CVE: any security issues such as vulnerabilities should be reported by email
support@ecsystems.nl (start the subject line with "CVE:"), a security engineer
ticket will be created and dealt with a.s.a.p.

Builds can be found here:
  http://nginx-win.ecsds.eu/
  Follow releases https://twitter.com/nginx4Windows

Todo:
- ldap / ntlm
- allow multiple instances to run on the same machine
- More non-blocking Lua, event based DLL add-on’s like pagespeed, SharePoint, asp/dotnet.
- Full 64 bit builds.
- IO event and thread separation (50% completed).
- Distributed IO and CPU event processing (we have a working proto type).

Feature list (* nginx_basic only):
=* All current nginx features (see with nginx.exe -V) (subject to Windows compatibility)
=* Consistent with original nginx code (subject to Windows compatibility)
=* FD_SETSIZE = 32768 (modded kernel), allows one worker to handle c250k+
   (with optimization registry file)
=* Multiple workers supported ! use no more than 2 workers for 1 core (cpu)
=* SPDY 3.1
=  LuaJIT compiled in (lua-nginx-module)
=  Streaming with nginx-rtmp-module
=  Naxsi WAF - Web Application Firewall
=  Array-var-nginx-module
=  HttpSubsModule
=  echo-nginx-module
=  ngx_http_lower_upper_case
=  headers-more-nginx-module
=  set-misc-nginx-module
=  ngx_http_auth_ldap (experimental)
=* Additional custom 503 error handler via 513
=  lua-upstream-nginx-module (Manipulate upstream dynamically)
=* Select-boost
=* Fully ASLR and DEP compliant for shared memory
=  encrypted-session-nginx-module
=  Nginx-limit-traffic-rate-module
=  RDNS (reverse DNS lookup for incoming connection)
=  AJP - tomcat backend support
=  form-input-nginx-module
=  ngxLuaDB, the drizzle and dynamic loaded module solution
=  ngx_upstream_jdomain
=  cache_purge
=  nginx-http-concat
=  nginx-module-vts (Virtual host traffic status)
Commercial subscription only modules:
=  nginx-vod-module (On-the-fly repackaging of MP4 files to DASH, HDS, HLS, MSS)
These native builds run on Windows XP SP3 and higher, both 32 and 64 bit.


*** Default installation instructions;
* New: unzip this version with folder structure
* Old: overwrite with this version
* Check nginx.conf, nginx-org.conf and nginx-win.conf
* Windows optimization registry file: check your current values BEFORE setting the new ones

*** Integrated installation instructions;
We have thought about building an installer but it seems far easier to lean on existing
combined packages which have nginx for Windows included, mind you these packages use
the official (limited) windows build by nginx but it is extremely easy to replace nginx.exe
with our version. For the most easiest replacement overwrite nginx.exe with nginx_basic.exe
from our package. If you want Lua and all the other advanced functions overwrite nginx.exe
with nginx.exe, place lua51.dll in the same folder as nginx.exe from our package and don't
forget to install vcredist_x86.exe or vcredist_x64.exe.
Example integrated packages are:
http://wtriple.com/wtnmp/
http://wpn-xm.org/
http://winginx.com/en/
A word of warning: keep in mind that integrated packages need to be kept up to date, that
means php, mysql, etc. all need to be upgraded whenever possible.
*** Anyway, we've made something :) see Install_nginx_php_services.zip on site.


Upgrade Assessment Matrix
-------------------------
I am using                Security Stability Performance Existing_Features New_Features
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.5.2 WhiteRabbit None     None      None        Medium            Medium
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.5.3 WhiteRabbit None     None      None        Medium            Low
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.7.1 WhiteRabbit Medium   None      None        Low               None
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.7.2 Gryphon     None     None      None        Low               Medium
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.8.1 Gryphon     None     None      None        Low               Medium
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.9.1 Gryphon     Low      Low       None        Low               Low
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.10.1 Gryphon    None     None      None        Low               None
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.11.1 Gryphon    None     None      None        Low               High
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.11.2 Gryphon    Medium   None      None        None              None
------------------------- -------- --------- ----------- ----------------- ------------
nginx 1.7.11.3 Gryphon    -        -         -           -                 -
------------------------- -------- --------- ----------- ----------------- ------------


20:43 19-3-2015 nginx 1.7.11.3 Gryphon

Based on nginx 1.7.11 (19-3-2015, last changeset 6024:199c0dd313ea) with;
+ Openssl-1.0.1m (CVE-2015-0204, CVE-2015-0286, CVE-2015-0287, CVE-2015-0289,
  CVE-2015-0292, CVE-2015-0293, CVE-2015-0209, CVE-2015-0288)
* In some cases the nginx processes won't stop normally when it's service is
  stopped (workers are still busy), it is advised to add this line:
  TASKKILL /F /IM "nginx*"
  at the end of your 'ngx_stop.cmd' file to make sure no workers are left
  behind before a new master and workers are started
+ Source changes back ported
+ Source changes add-on's: no changes
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: no (openssl fixes)
* Additional specifications: see 'Feature list'
* This is a non scheduled release of the last in the Gryphon series


22:02 14-3-2015 nginx 1.7.11.2 Gryphon

Based on nginx 1.7.11 (14-3-2015, last changeset 6005:d84f0abd4a53) with;
+ nginx-module-vts (Virtual host traffic status)
  adding monitoring for your NOC (network operations center)
  see /conf/vhts
  see our updated 'nginx for Windows - documentation 1.1.pdf' chapter 13
+ set-misc-nginx-module v0.28 (upgraded 10-3-2015)
+ echo-nginx-module v0.57 (upgraded 8-3-2015)
+ lua-nginx-module v0.9.16 (upgraded 10-3-2015)
* nginx for Windows is safe against SSL FREAK attack
+ new best practice ssl_ciphers example (nginx-win.conf)
+ 'include' in upstream http://trac.nginx.org/nginx/ticket/635
+ nginx-auth-ldap (upgraded 2-3-2015)
+ Inter Worker Communication Protocol to support multiple workers with EBLB
  IWCP updated to v0.3 (if you like to keep up to date with IWCP/EBLB for
  other OS's then follow nginx for Windows releases, all Lua code should
  be cross OS compatible)
  see our updated 'nginx for Windows - documentation 1.1.pdf' chapter 10
  with EBLB and IWCP in action, what it can do for you, including examples
+ EBLB (Elastic Backend Load Balancer), see /conf/EBLB
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'
* This is the last of the Gryphon series, watch out for the new release name


13:31 18-2-2015 nginx 1.7.11.1 Gryphon

Based on nginx 1.7.11 (17-2-2015, last changeset 5984:3f568dd68af1) with;
* Introducing 'nginx for Windows - documentation 1.0', see our new
  documentation repository
* Documentation repository http://nginx-win.ecsds.eu/download/documentation-pdf/
+ Naxsi WAF v0.53-3 (upgraded 16-2-2015)
* See 'ramdisk_setup v3.4.6.exe' on site, speedup your microcache 500x
* (PHP) xcache and (PHP 5.5+) opcache examples in /conf
+ lua-nginx-module v0.9.14 (upgraded 16-2-2015)
* nginx for Windows is not affected by CVE-2015-0235 (Ghost)
+ nginx-auth-ldap (upgraded 22-1-2015)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


19:14 17-1-2015 nginx 1.7.10.1 Gryphon

Based on nginx 1.7.10 (15-1-2015, last changeset 5964:0a198a517eaf) with;
+ reverted changeset 5962:727177743c3c (causing segfaults)
+ set-misc-nginx-module v0.27 (upgraded 14-1-2015)
+ HttpSubsModule v0.6.4 (upgraded 14-1-2015)
+ lua-nginx-module v0.9.13 (upgraded 14-1-2015)
+ prove05.zip (onsite), a Windows Test_Suite (updated 16-1-2015)
+ See http://nginx-win.ecsds.eu/devtest/EBLB_upstream_dev1.zip for a partly
  working example of managing backends
+ reverted changesets 5960:e9effef98874 and 5959:f7584d7c0ccb (breaks too many
  things, needs re-engineering)
+ Openssl-1.0.1l (CVE-2014-3571, CVE-2015-0206, CVE-2014-3569, CVE-2014-3572, 
  CVE-2015-0204, CVE-2015-0205, CVE-2014-8275, CVE-2014-3570)
+ cache_purge v2.3 (upgraded 30-12-2014)
+ Naxsi WAF v0.53-3 (upgraded 30-12-2014)
+ ngx_signal_process, http://forum.nginx.org/read.php?29,255612
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


12:00 17-12-2014 nginx 1.7.9.1 Gryphon

Based on nginx 1.7.9 (12-12-2014, last changeset 5945:99751fe3bc3b) with;
+ win32 file properties
+ nginx-http-concat v1.2.2 (https://github.com/alibaba/nginx-http-concat)
+ prove04.zip (onsite), a Windows Test_Suite (updated 7-12-2014)
+ cache_purge v2.2 (upgraded 4-12-2014)
+ lua-nginx-module v0.9.13 (upgraded 12-12-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'
* This is the last scheduled release for 2014, have a great xmas and see ya'all in 2015 !


21:38 17-11-2014 nginx 1.7.8.1 Gryphon

Based on nginx 1.7.8 (17-11-2014, last changeset 5904:abb466a57a22) with;
+ Naxsi WAF v0.53-3 (upgraded 15-11-2014)
+ https://github.com/nginx/nginx/pull/7 has been added to code base
  changeset 5900:20d966ad5e89
+ Updated Install_nginx_php_services.zip on site to v1.3
+ Updated, simple Web Application Firewall, see conf/nginx-simple-WAF.conf
+ cache_purge (https://github.com/FRiCKLE/ngx_cache_purge)
+ set-misc-nginx-module v0.26 (upgraded 1-11-2014)
+ lua-nginx-module v0.9.13rc1 (upgraded 15-11-2014)
+ nginx-rtmp-module, v1.1.6 (upgraded 31-10-2014)
+ Re-engineered changeset 5894:1f513d7f1b45
+ Re-engineered changeset 5896:3efdd7788bb0
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


22:55 15-10-2014 nginx 1.7.7.2 Gryphon

Tell me a story and I'll tell you my history. The Mock Turtle and the Gryphon
are here to stay. What! Never heard of uglifying! If you don't know what to
uglify is, you are a simpleton so you'd better get on your way.
The nginx Gryphon release is here!

Based on nginx 1.7.7 (15-10-2014, last changeset 5876:973fded4f461) with;
+ Openssl-1.0.1j (CVE-2014-3513, CVE-2014-3567, SSL 3.0 Fallback protection,
  CVE-2014-3568)
+ lua-nginx-module v0.9.13rc1 (upgraded 15-10-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: no (openssl fixes)
* Additional specifications: see 'Feature list'


11:24 5-10-2014 nginx 1.7.7.1 WhiteRabbit

Based on nginx 1.7.7 (2-10-2014, last changeset 5868:6bbad2e73245) with;
+ pcre-8.36 (upgraded, regression tested)
+ nginx-auth-ldap (upgraded 22-9-2014)
+ nginx-rtmp-module, v1.1.5 (upgraded 22-9-2014)
+ lua-nginx-module v0.9.13 (upgraded 22-9-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'
* This is the last of the WhiteRabbit series, watch out for the new release name


18:42 15-9-2014 nginx 1.7.5.3 WhiteRabbit

Based on nginx 1.7.5 (15-9-2014, last changeset 5834:ca63fc5ed9b1) with;
+ lua-upstream-nginx-module v0.2 (upgraded 14-9-2014)
+ echo-nginx-module v0.56 (upgraded 14-9-2014)
+ nginx-rtmp-module, v1.1.4 (upgraded 14-9-2014)
  includes https://github.com/arut/nginx-rtmp-module/pull/469
+ lua-nginx-module v0.9.13 (upgraded 14-9-2014)
+ Re-engineered changeset 5820:3377f9459e99, nice try but no sigar
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


22:40 20-8-2014 nginx 1.7.5.2 WhiteRabbit

Based on nginx 1.7.5 (20-8-2014, last changeset 5809:bb26f7ceaaf1) with;
+ ngx_upstream_jdomain (https://github.com/wdaike/ngx_upstream_jdomain)
+ https://github.com/nginx/nginx/pull/7, adding:
  proxy_ssl_client_certificate      cert.pem;
  proxy_ssl_client_certificate_key  cert.key;
  our first multi node cross compiler import !
+ A very simple Web Application Firewall, see conf/nginx-simple-WAF.conf
+ Updated ngxLuaDB to 1.1 (on site !) the drizzle, partial openresty
  and dynamic library / loaded module solution
+ lua-nginx-module v0.9.11 (upgraded 20-8-2014)
+ form-input-nginx-module v0.10 (upgraded 17-8-2014)
+ echo-nginx-module v0.55 (upgraded 19-8-2014)
+ set-misc-nginx-module v0.25 (upgraded 19-8-2014)
+ headers-more-nginx-module v0.25 (upgraded 19-8-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


19:48 7-8-2014 nginx 1.7.5.1 WhiteRabbit

Based on nginx 1.7.5 (7-8-2014, last changeset 5801:ab48149b77a6) with;
+ Openssl-1.0.1i (CVE-2014-3508, CVE-2014-5139, CVE-2014-3509,
  CVE-2014-3505, CVE-2014-3506, CVE-2014-3507, CVE-2014-3510,
  CVE-2014-3511, CVE-2014-3512)
+ lua-nginx-module v0.9.11 (upgraded 6-8-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: no (openssl fixes)
* Additional specifications: see 'Feature list'


19:59 5-8-2014 nginx 1.7.5.0 WhiteRabbit

Based on nginx 1.7.5 (5-8-2014, last changeset 5789:930ce13f19ab) with;
+ nginx fix for CVE-2014-3556
+ lua-nginx-module v0.9.11 (upgraded 30-7-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: no, CVE-2014-3556
* Additional specifications: see 'Feature list'


22:40 26-7-2014 nginx 1.7.4.2 WhiteRabbit

"I'm late! I'm late! For a very important date! No time to say hello,
goodbye! I'm late! I'm late! I'm late!"
The nginx WhiteRabbit release is here!

Based on nginx 1.7.4 (25-7-2014, last changeset 5771:c3b08217f2a2) with;
+ See Install_nginx_php_services.zip on site !
+ set-misc-nginx-module v0.24 (upgraded 26-7-2014)
+ echo-nginx-module v0.54 (upgraded 19-7-2014)
+ lua-nginx-module v0.9.11 (upgraded 25-7-2014)
+ form-input-nginx-module v0.09 (upgraded 23-7-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'
* This release is dedicated to our beloved Yorkshire terrier Peewee who
  aged 11,5 years passed away on Sunday July 20 at 15.15, we shall miss
  him dearly.


15:54 13-7-2014 nginx 1.7.4.1 RedKnight

Based on nginx 1.7.4 (11-7-2014, last changeset 5767:abd460ece11e) with;
+ lua-nginx-module v0.9.11 (upgraded 12-7-2014)
+ echo-nginx-module v0.54 (upgraded 3-7-2014)
+ form-input-nginx-module v0.09 (upgraded 3-7-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'
* This is the last of the RedKnight series, watch out for the new release name


12:37 21-6-2014 nginx 1.7.3.1 RedKnight

Based on nginx 1.7.3 (20-6-2014) with;
+ new best practice ssl_ciphers example (nginx-win.conf)
+ fastcgi/upstream fix: http://forum.nginx.org/read.php?29,250947,251007#msg-251007
+ form-input-nginx-module (https://github.com/calio/form-input-nginx-module)
+ Naxsi WAF conf\naxsi_core.rules updated 15-6-2014; File uploads: 1500-1600
+ nginx-auth-ldap (upgraded 12-6-2014)
+ lua-nginx-module v0.9.9 (upgraded 16-6-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: yes
* Additional specifications: see 'Feature list'


20:13 5-6-2014 nginx 1.7.2.2 RedKnight

Based on nginx 1.7.2 (5-6-2014) with;
+ Openssl-1.0.1h (CVE-2014-0224, CVE-2014-0221, CVE-2014-0195,
  CVE-2014-0198, CVE-2010-5298, CVE-2014-3470)
+ New nginx Windows icon
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Scheduled release: no (openssl fixes)
* Additional specifications: see 'Feature list'


14:53 1-6-2014 nginx 1.7.2.1 RedKnight

Based on nginx 1.7.2 (30-5-2014) with;
+ optimization registry file renamed
+ FD table size increased to allow more sustained power with a single worker
+ original nginx:syslog support
+ RFC 6302 EU-SP legislation log source ports: 
  use $remote_addr:$remote_port when using log_format
+ lua-nginx-module v0.9.8 (upgraded 1-6-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications: see 'Feature list'


17:21 17-5-2014 nginx 1.7.1.3 RedKnight

Go ask Alice, I think she'll know, When logic and proportion have
fallen dead And the white knight is talking backwards And the red
queen's lost her head Remember what the dormouse said Feed your head,
feed your head, as the RedKnight rizes again from the dead !
The nginx RedKnight release is here /->
             ,      ,  /
        ____/~\    ~O
    ,;~( )_  )'' /~()'-{---
       )/  |(     /~)
       ~    ~     ~ ~
     Phil/sb/Donovan/mbfh

Based on nginx 1.7.1 (16-5-2014) with;
+ Openssl fix for out-of-bounds write in SSL_get_shared_ciphers (#3317)
+ integration of Mercurial and Git into our crosscompiler
  this reduces diff sets import and cross checks from 12 to 1 hour
+ lua-nginx-module v0.9.7 (upgraded 15-5-2014)
+ Select-boost is out of beta and is now the default
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications: see 'Feature list'


13:56 2-5-2014 nginx 1.7.1.2 Snowman

Based on nginx 1.7.1 (30-4-2014) with;
+ lua-nginx-module v0.9.7 (upgraded 1-5-2014)
+ Openssl fix for CVE-2010-5298
+ AJP tomcat backend support (https://github.com/yaoweibin/nginx_ajp_module)
  Note: a folder '.\nginx\ajp_temp' will be created, when running nginx jailed
  create it yourself and set additional rights for the service user who runs
  nginx to allow access
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications: see 'Feature list'


21:28 24-4-2014 nginx 1.7.1.1 Snowman

Based on nginx 1.7.1 (24-4-2014) with;
+ lua-upstream-nginx-module v0.1 (upgraded 24-4-2014)
+ Streaming with nginx-rtmp-module, v1.1.4 (upgraded 24-4-2014)
+ New development tree nginx export 1.7
+ Naxsi WAF v0.53-1 (upgraded 17-4-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications: see 'Feature list'


23:55 12-4-2014 nginx 1.5.14.1 Snowman

Based on nginx 1.5.14 (11-4-2014) with;
+ echo-nginx-module v0.53 (upgraded 12-4-2014)
+ Should I upgrade? (Upgrade Assessment Matrix)
+ lua-nginx-module v0.9.7 (upgraded 11-4-2014)
+ Streaming with nginx-rtmp-module, v1.1.4 (upgraded 11-4-2014)
+ set-misc-nginx-module (upgraded 11-4-2014)
+ RDNS (https://github.com/flant/nginx-http-rdns) (upgraded 11-4-2014, it's back!)
+ pcre-8.35 (upgraded)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications: see 'Feature list'


CVE-2014-0160 (heartbleed / heartbeat) statement: as of version 'nginx 1.5.13.2 Snowman'
nginx for Windows is not affected by CVE-2014-0160, this version uses openssl-1.0.1g, any
previous version can be vulnerable.


10:30 8-4-2014 nginx 1.5.13.2 Snowman

Based on nginx 1.5.13 (8-4-2014) with;
+ CVE fix CVE-2014-0160
+ openssl-1.0.1g (upgraded 8-4-2014)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications are like 0:18 5-4-2014 nginx 1.5.13.1 Snowman


0:18 5-4-2014 nginx 1.5.13.1 Snowman

.-= This Is Snowman =-.
Here's a little snowman fast and fat, here's it's power as fast as a cat
When you run Windows you can hear it shout, take me in try me out!
The nginx Snowman release is here!

Based on nginx 1.5.13 (3-4-2014) with;
+ A fix for ssl_session_cache via trac ticket #528, thanks to Maxim!
+ Stability fixes, more performance tuning
+ multiple workers now use an api (efficiency and control)
+ Streaming with nginx-rtmp-module, v1.1.4 (upgraded 3-4-2014)
+ Naxsi WAF v0.53-1 (upgraded 3-4-2014, conf\naxsi_core.rules id 15+16)
+ LuaJIT-2.0.3 (upgraded 31-3-2014) Tnx to Mike Pall for his hard work!
+ lua51.dll (upgraded 31-3-2014) DO NOT FORGET TO REPLACE THIS FILE !
+ lua-nginx-module v0.9.7 (upgraded 3-4-2014)
+ FAQ included in archive
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications are like 20:29 18-3-2014 nginx 1.5.12.2 Cheshire


20:29 18-3-2014 nginx 1.5.12.2 Cheshire

Based on nginx 1.5.12 (release 18-3-2014) with;
+ nginx security advisory (CVE-2014-0133)
+ echo-nginx-module v0.51 (upgraded 18-3-2014)
+ Nginx-limit-traffic-rate-module (https://github.com/bigplum/Nginx-limit-traffic-rate-module)
+ lua-nginx-module v0.9.6 (upgraded 18-3-2014)
+ changed compile order (openresty)
+ Source changes back ported
+ Source changes add-on's back ported
+ Changes for nginx_basic: Source changes back ported
* Additional specifications are like 13:58 9-3-2014 nginx 1.5.12.1 Cheshire


13:58 9-3-2014 nginx 1.5.12.1 Cheshire

Based on nginx 1.5.12 (9-3-2014) with;
+ Fixed a c99 logging issue in naxsi
+ Now includes nginx_basic. Need a simple powerful Windows webserver without all the
  bling of it's big brother ? then nginx_basic is for you, other custom builds are
  available upon request
+ nginx security advisory (CVE-2014-0088)
+ encrypted-session-nginx-module (https://github.com/agentzh/encrypted-session-nginx-module)
+ Fully ASLR and DEP compliant for shared memory (ea. limit_conn_zone, limit_req_zone, etc.)
+ lua-upstream-nginx-module (https://github.com/agentzh/lua-upstream-nginx-module)
+ lua-nginx-module v0.9.5rc2 (upgraded 8-3-2014)
+ Streaming with nginx-rtmp-module, v1.1.3 (upgraded 8-3-2014)
+ echo-nginx-module v0.51 (upgraded 21-2-2014)
+ headers-more-nginx-module v0.25 (upgraded 17-1-2014)
+ nginx-auth-ldap (upgraded 21-2-2014)
+ HttpSubsModule (upgraded 21-2-2014)
+ Additional custom 503 error handler via 513 (see onsite readme for example)
  Issue: a "return 503" can only be used once in a location block, when a custom 503
         is used for example with limit_req_zone you can't have a second custom 503
	 for a maintenance page
  example:
    server {
        listen  80;
        server_name  www.any.nl;
        root    '/webroot/www.any.nl';
        error_page 503 @floodnotice;
        error_page 513 @maintenance;
        location / {
            if (-f $document_root/maintenance_mode.html) { return 513; }
            # Or with a local IP check
            ## Note: there is a bug with this last IF, see http://forum.nginx.org/read.php?2,251650
            ## for more info about this incorrect behavior (dd. 12-7-2014)
            # set $maintmode S; if ($remote_addr ~ "^(10.10.*.*)$") { set $maintmode L; }
            # if (-f $document_root/maintenance_mode.html) { set $maintmode "${maintmode}M"; }
            # if ($maintmode = SM) { return 513; }
            # Yes we all know by now, ifisevil so put a sock in it
            # Or with pure Lua, no IF issues
            ## rewrite_by_lua '
            ##   local s = 0; local v = 0;
            ##   local source_fname = ngx.var.document_root .. "/maintenance_mode.html";
            ##   local file = io.open(source_fname);
            ##   if file then v=1; file:close(); end;
            ##   if string.find(ngx.var.remote_addr, "^10.10.30.") then v=0; end;
            ##   if v>0 then return ngx.exit(513); end;
            ## ';
            try_files $uri $uri/ =404;
            index  index.html index.htm;
            limit_req zone=floodh burst=32 nodelay;
            # generates a 503 when triggered
            # see limit_req_zone directive how limit_req works
        }
        location @floodnotice {
            root html
            rewrite ^ /floodnotice.html break;
        }
        location @maintenance {
            rewrite ^ /maintenance_mode.html break;
            # process a 513 but return a 503 to client !
        }
    }
  The normal behavior would be (if the file exists) to return the contents 
  of "/maintenance_mode.html" with a "HTTP/1.1 200 OK", or when the 503 error_page
  is used a 503, however a 503 is often used for other things, With this new 513
  error_page the same thing can be done but the 513 is replaced with a 503 when
  the headers are compiled which allows you to use the real 503 for other things
+ Select-boost: event driven, non-blocking API select() replacement, Beta
  No need to enable anything, it is fully automatic and won't be used if certain
  conditions do not pass internal tests
+ Source changes back ported
+ Source changes add-on's back ported
* Additional specifications are like 14:05 10-1-2014: nginx 1.5.9.1 Cheshire


14:05 10-1-2014: nginx 1.5.9.1 Cheshire

When she sleeps she gently purrs, you hardly know she's there, but when she wakes
you're gonna hear her roar. nginx Cheshire release is here !
This native build runs on Windows XP SP3 and higher, both 32 and 64 bit.

Based on nginx 1.5.9 (4-1-2014) with;
+ changed compile order
+ prove01.zip (onsite), a Windows Test_Suite way to show/prove it all really works
+ ngx_http_auth_ldap2 (experimental, https://github.com/kvspb/nginx-auth-ldap)
  follow examples on github site, not the site example in example.conf, this is an
  experimental build addition ! (when not used it won't affect anything else)
+ set-misc-nginx-module (https://github.com/agentzh/set-misc-nginx-module)
+ headers-more-nginx-module (https://github.com/agentzh/headers-more-nginx-module)
+ openssl-1.0.1f (upgraded 8-1-2014)
+ lua-nginx-module v0.9.4 (upgraded 9-1-2014)
+ Streaming with nginx-rtmp-module, v1.1.1 (upgraded 10-1-2014)
+ echo-nginx-module v0.50 (upgraded 8-1-2014)
- RDNS has been removed until a blocking issue has been resolved
+ added http_auth_request_module
+ Source changes back ported
+ Source changes add-on's back ported
* Additional specifications are like 19:46 18-12-2013: nginx 1.5.8.3 Caterpillar


19:46 18-12-2013: nginx 1.5.8.3 Caterpillar

Based on nginx 1.5.8 (release) with;
+ prove.zip (onsite), a Windows Test_Suite way to show/prove it all really works
  with at the moment a limited amount of tests which will grow over time
+ Streaming with nginx-rtmp-module, v1.0.8 (upgraded 16-12)
+ pcre-8.34 (upgraded)
+ lua-nginx-module v0.9.3 (upgraded)
+ echo-nginx-module v0.50 (upgraded)
+ Source changes back ported (including fixes for the changed resolver API)
+ Source changes add-on's back ported (including fixes for the changed resolver API)
* More compiler optimizations
* Additional specifications are like 15:34 6-12-2013: nginx 1.5.8.2 Caterpillar


15:34 6-12-2013: nginx 1.5.8.2 Caterpillar

Based on nginx 1.5.8 (5-12-2013) with;
+ Fix for nginx -t 'Assertion failed' issue
+ HttpSubsModule (https://github.com/yaoweibin/ngx_http_substitutions_filter_module)
+ echo-nginx-module (https://github.com/agentzh/echo-nginx-module)
+ ngx_http_lower_upper_case (https://github.com/replay/ngx_http_lower_upper_case)
+ Naxsi WAF (Web Application Firewall) v0.53-1 (upgraded 5-12-2013)
+ lua-nginx-module v0.9.2 (upgraded 6-12)
+ Streaming with nginx-rtmp-module, v1.0.8 (upgraded 6-12)
+ Source changes back ported
+ Source changes add-on's back ported
* The debug version is no longer needed, Intel static profiler data is used
  nginx crash info/logging or event dump info is all that is needed
* Intel static profiler "the need for speed" compiler optimization
* Additional specifications are like 19:18 30-11-2013: nginx 1.5.8.1 Caterpillar


19:18 30-11-2013: nginx 1.5.8.1 Caterpillar

Based on nginx 1.5.8 (29-11-2013) with (mainly bugfixes in add-on's);
+ Naxsi WAF (Web Application Firewall) v0.53-1 (upgraded)
+ lua-nginx-module v0.9.2 (upgraded 30-11)
+ Streaming with nginx-rtmp-module, v1.0.8 (upgraded 29-11)
+ Source changes back ported
+ Source changes add-on's back ported
* Additional specifications are like 20:32 19-11-2013: nginx 1.5.7.2 Caterpillar


20:32 19-11-2013: nginx 1.5.7.2 Caterpillar

Based on nginx 1.5.7 (19-11-2013) with;
+ nginx fix for CVE-2013-4547 (nginx 1.5.7.1 Caterpillar removed from download)
+ Source changes back ported
+ Simplified new installations
* Additional specifications are like 12:22 16-11-2013: nginx 1.5.7.1 Caterpillar


12:22 16-11-2013: nginx 1.5.7.1 Caterpillar

The nginx 'Caterpillar' is a "you are no longer in Kansas Alice" *MONSTER* release bringing
to Windows full scalability with multiple workers!
This native build runs on Windows XP SP3 and higher, both 32 and 64 bit.

Based on nginx 1.5.7 (9-11-2013 + spdy hang fix) with;
+ A solution for the multiple worker(shm_) issue, commercially sponsored solution by ITPP
  with a HUGE thanks to Vittorio Francesco Digilio from Italy for his relentless debugging,
  analysis and solution !
+ Naxsi WAF (Web Application Firewall) v0.53 (https://github.com/nbs-system/naxsi)
  see https://github.com/nbs-system/naxsi/wiki how to use it and also see the conf/ folder
+ lua-nginx-module v0.9.2 (upgraded)
+ Streaming with nginx-rtmp-module, v1.0.6 (http://nginx-rtmp.blogspot.nl/) (upgraded)
* Additional specifications are like 12:38 2-10-2013: nginx 1.5.6.4 Butterfly


12:38 2-10-2013: nginx 1.5.6.4 Butterfly

The Nginx 'Butterfly' release brings to Windows stable and unleashed power of Nginx, Lua, 
Streaming feature, Reverse DNS, SPDY, easy c250k in a non-blocking and event driven build 
which runs on Windows XP SP3 or higher, both 32 and 64 bit.

Based on nginx 1.5.6 (release) with;
+ RDNS (https://github.com/flant/nginx-http-rdns)
+ Array-var-nginx-module (https://github.com/agentzh/array-var-nginx-module)
+ ngx_devel_kit v0.2.19
+ lua-nginx-module v0.9.0
* Additional specifications are like 13:46 25-9-2013: nginx 1.5.6.3 Alice


13:46 25-9-2013: nginx 1.5.6.3 Alice

Based on nginx 1.5.6 (25-9-2013) with;
+ Bug fixes in lua-nginx-module(master 25-9-2013) and ngx_devel_kit(master 25-9-2013) by agentzh
+ Both debug and non-debug versions, the non-debug version is production use ready ! 
* vcredist_x86 is required, get it here (http://www.microsoft.com/en-us/download/details.aspx?id=5555)
* Additional specifications are like 10:37 23-9-2013: nginx 1.5.6.1 Alice
* 1.5.6.2 was skipped for public release


10:37 23-9-2013: nginx 1.5.6.1 Alice

Based on nginx 1.5.6 (22-9-2013) with;
+ Streaming with nginx-rtmp-module, v1.0.4 (http://nginx-rtmp.blogspot.nl/)
+ lua-nginx-module v0.8.9 (tnx to agentzh about precompiled headers!)
+ LuaJIT-2.0.2 => (lua51.dll include / lua51.lib build)
+ Added lua51.dll (is required)
+ ngx_devel_kit v0.2.15
* Additional specifications are like 10:27 10-9-2013: B02 build


10:27 10-9-2013: B02 build

Based on nginx 1.4.2 with;
  pcre-8.32
  zlib-1.2.8
  openssl-1.0.1e
+ Compiled with: FD_SETSIZE = 16384 (original Windows source files modified)
+ Now capable to handle C250K ! (with optimization registry file)
+ Added Windows optimization registry file, check your current values BEFORE setting the new ones
+ Added debug symbols file (let us know where it went wrong when you have a crash)
+ Added adjusted nginx(-win).conf for Windows
+ Added SPDY
* Runs on Windows XP SP3 or higher, both 32 and 64 bit
* Set priority to High for both nginx.exe processes
* When nginx is running as a service: My computer -> Properties -> Advanced -> Performance -> 
  Advanced -> Processor scheduling, Adjust for best performance set to background services
* Website created for easy download: http://nginx-win.ecsds.eu/


				  DISCLAIMER

Use of this program acknowledges this disclaimer of warranty:
"This program is supplied as is. The author(s) and associated companies disclaims all warranties,
express or implied, including, without limitation, the warranties of merchantability and of fitness
of this program for any purpose. The author(s) and associated companies assumes no liability for
damages direct or consequential, which may result from the use of or inability to use this program.
Even if author(s) and associated companies has been advised of the possibility of such damages or
any claim by any other party."
