## MongoDB Replica Set Kurulumu ve Yapılandırma Notları

### 1. Replica Set Başlatma

Replica set'i başlatmak için `mongosh` ile `mongo-0` pod'una bağlandıktan sonra aşağıdaki komutları çalıştırdım:

```js
rs.initiate()
```

### 2. PRIMARY Adresini Düzenleme

Replica set konfigürasyonunda PRIMARY'nin adresini tam DNS ile güncellemem gerekti:

```bash
cfg = rs.conf()
cfg.members[0].host = "mongo-0.mongo-set.mongodb.svc.cluster.local:27017"
rs.reconfig(cfg, { force: true })
```

### 3. SECONDARY Üyeleri Ekleme

Ardından diğer üyeleri ekledim:

```bash
rs.add("mongo-2.mongo-set.mongodb.svc.cluster.local:27017")
```

### 4. Versiyon Sorunu

Kullandığım cluster eski işlemcili olduğu için MongoDB 5.0+ sürümleri çalışmadı. Bu yüzden MongoDB 4.4 sürümüne kadar düşmem gerekti.

### 5. Sidecar'ı Kaldırma

Sidecar container'ı kaldırdım, çünkü artık gerekli değildi.

### 6. Pod'lar Arası İletişim

Container'ların birbirini DNS ile çözebilmesi için `ClusterIP: None` tipinde bir  service oluşturmak zorunda kaldım.

### 7. MongoDB Compass ile Bağlantı

MongoDB Compass dışarıdan replica set üyelerinin DNS'ini çözemediği için şu bağlantı URI'si ile bağlanmak zorunda kaldım:

```
mongodb://localhost:27017/?directConnection=true
```
