<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Realistic 3D PC Simulator ($4500)</title>
    <style>
        * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    width: 100vw;
    height: 100vh;
    overflow: hidden; /* Запрещает появление ненужных полос прокрутки */
    margin: 0;
}
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', system-ui, sans-serif; }
        body { background: #050811; color: #fff; overflow: hidden; }
        #canvas-container { width: 100vw; height: 100vh; position: absolute; }
        
        .ui {
            position: absolute; top: 20px; right: 20px; width: 380px;
            background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 16px;
            padding: 20px; z-index: 10; box-shadow: 0 20px 40px rgba(0,0,0,0.6);
        }
        .title { font-size: 1.2rem; font-weight: 700; margin-bottom: 10px; color: #38bdf8; }
        .budget { background: rgba(0,0,0,0.4); padding: 10px; border-radius: 8px; font-weight: 600; margin-bottom: 15px; color: #4ade80; }
        .btn-action {
            width: 100%; padding: 12px; border: none; border-radius: 10px;
            background: #2563eb; color: #fff; font-weight: 700; cursor: pointer;
            transition: 0.2s; margin-top: 10px;
        }
        .btn-action:hover { background: #1d4ed8; }
        .controls-info {
            position: absolute; bottom: 20px; left: 20px;
            background: rgba(0,0,0,0.6); padding: 8px 16px; border-radius: 20px;
            font-size: 0.85rem; color: #94a3b8; pointer-events: none;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
    <!-- Подключаем загрузчик 3D-моделей GLTF/GLB -->
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/GLTFLoader.js"></script>
</head>
<body>

    <div id="canvas-container"></div>

    <div class="ui">
        <div class="title">Realistic 3D Builder</div>
        <div class="budget">Бюджет: $4,500</div>
        <p style="font-size: 0.85rem; color: #94a3b8; margin-bottom: 15px;">
            Вращайте сцену мышкой. Каждая деталь имеет PBR-материалы (металл, стекло, пластик).
        </p>
        <button class="btn-action" onclick="toggleRGB()">Переключить RGB Подсветку</button>
    </div>

    <div class="controls-info">🖱️ ЛКМ — Вращение | ПКМ — Сдвиг | Колесико — Зум</div>

    <script>
    window.addEventListener('resize', () => {
    // Обновляем пропорции камеры
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    // Обновляем размер холста рендерера
    renderer.setSize(window.innerWidth, window.innerHeight);
});
        // --- 1. Сцена, Камера и Рендерер с постобработкой ---
        const scene = new THREE.Scene();
        scene.fog = new THREE.FogExp2(0x050811, 0.02);

        const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(3, 1.5, 3.5);

        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        renderer.toneMapping = THREE.ACESFilmicToneMapping; // Кинематографическая цветопередача
        renderer.toneMappingExposure = 1.2;
        document.getElementById('canvas-container').appendChild(renderer.domElement);

        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;

        // --- 2. Реалистичный свет ---
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.8);
        scene.add(ambientLight);

        const mainSpot = new THREE.SpotLight(0xffffff, 2);
        mainSpot.position.set(5, 8, 5);
        mainSpot.castShadow = true;
        mainSpot.shadow.mapSize.width = 2048;
        mainSpot.shadow.mapSize.height = 2048;
        scene.add(mainSpot);

        // Точечная RGB подсветка внутри корпуса
        const rgbLight = new THREE.PointLight(0x00f0ff, 3, 5);
        rgbLight.position.set(0, 0.2, 0);
        scene.add(rgbLight);

        // --- 3. Создание детализированных объектов (PBR) ---
        const pcGroup = new THREE.Group();
        scene.add(pcGroup);

        // Деревянный стол с текстурированной шероховатостью
        const tableGeo = new THREE.BoxGeometry(8, 0.1, 4);
        const tableMat = new THREE.MeshStandardMaterial({ color: 0x111625, roughness: 0.4, metalness: 0.1 });
        const table = new THREE.Mesh(tableGeo, tableMat);
        table.position.y = -1.05;
        table.receiveShadow = true;
        scene.add(table);

        // Корпус: Металл + Закаленное Стекло
        function createRealisticCase() {
            const caseGroup = new THREE.Group();
            
            // Шлифованный металл
            const metalMat = new THREE.MeshStandardMaterial({ color: 0x0f172a, metalness: 0.85, roughness: 0.25 });
            
            // Шасси корпуса
            const frame = new THREE.Mesh(new THREE.BoxGeometry(1.4, 2.0, 1.8), metalMat);
            frame.position.set(0, 0, 0);
            
            // Вырез под стекло (Закаленное прозрачное стекло)
            const glassMat = new THREE.MeshPhysicalMaterial({
                color: 0xffffff,
                transparent: true,
                opacity: 0.2,
                roughness: 0.05,
                metalness: 0.1,
                transmission: 0.9, // Эффект стекла
                ior: 1.5
            });
            const glassPanel = new THREE.Mesh(new THREE.BoxGeometry(1.38, 1.95, 0.02), glassMat);
            glassPanel.position.set(0, 0, 0.9);

            caseGroup.add(frame, glassPanel);
            return caseGroup;
        }

        // Детализированная видеокарта (RTX 4090 Style)
        function createDetailedGPU() {
            const gpu = new THREE.Group();
            const bodyMat = new THREE.MeshStandardMaterial({ color: 0x1e293b, metalness: 0.9, roughness: 0.2 });
            const fanMat = new THREE.MeshStandardMaterial({ color: 0x020617, metalness: 0.5, roughness: 0.5 });
            const rgbMat = new THREE.MeshBasicMaterial({ color: 0x00f0ff });

            // Главный кожух
            const mainBody = new THREE.Mesh(new THREE.BoxGeometry(0.85, 0.35, 1.3), bodyMat);
            gpu.add(mainBody);

            // RGB-полоса на видеокарте
            const rgbStrip = new THREE.Mesh(new THREE.BoxGeometry(0.87, 0.04, 1.2), rgbMat);
            rgbStrip.position.y = 0.15;
            gpu.add(rgbStrip);

            // 3 Вентилятора с лопастями
            for(let i = -1; i <= 1; i++) {
                const fanRim = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.02, 32), fanMat);
                fanRim.rotation.x = Math.PI / 2;
                fanRim.position.set(0.43, 0, i * 0.4);
                gpu.add(fanRim);
            }

            gpu.position.set(0, -0.2, 0);
            return gpu;
        }

        pcGroup.add(createRealisticCase());
        pcGroup.add(createDetailedGPU());

        /* 
           ПРИМЕЧАНИЕ: Для использования готовых файлов .GLB/.GLTF из Blender:
           const loader = new THREE.GLTFLoader();
           loader.load('path/to/rtx4090.glb', (gltf) => {
               pcGroup.add(gltf.scene);
           });
        */

        // --- 4. Анимация ---
        let rgbMode = 0;
        function toggleRGB() {
            rgbMode = (rgbMode + 1) % 3;
            if(rgbMode === 0) rgbLight.color.setHex(0x00f0ff);
            if(rgbMode === 1) rgbLight.color.setHex(0xff0055);
            if(rgbMode === 2) rgbLight.color.setHex(0x10b981);
        }

        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            pcGroup.rotation.y += 0.002; // Плавное вращение демонстрации
            renderer.render(scene, camera);
        }

        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });

        animate();
    </script>
</body>
</html>
