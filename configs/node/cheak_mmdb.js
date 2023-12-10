const geoip = require('geoip-lite');

// 指定要查询的IP地址
const ipAddress = '14.144.0.0';

// 设置.mmdb文件的路径
const databasePath = 'C:\\Users\\1box\\Desktop\\GeoLite2-Country.mmdb';

// 加载.mmdb文件
geoip.startWatchingDataUpdate(databasePath);

// 查询IP地址的地理位置信息
const geo = geoip.lookup(ipAddress);

// 输出结果
console.log('IP地址:', ipAddress);
console.log('国家代码:', geo.country);
console.log('国家名称:', 'geoip:' + geo.country.toLowerCase());
console.log('地区名称:', geo.region);
console.log('城市名称:', geo.city);
console.log('经纬度:', geo.ll);

// 退出Node.js进程
process.exit();
