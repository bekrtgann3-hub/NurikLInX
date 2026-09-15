<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hardware Builder — Собери свой ПК</title>

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background:
        radial-gradient(circle at 20% 20%, rgba(50,80,160,.18), transparent 30%),
        radial-gradient(circle at 80% 70%, rgba(120,40,180,.15), transparent 30%),
        #070910;
    color: #fff;
    min-height: 100vh;
}

/* ================= HEADER ================= */

header {
    height: 76px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 35px;
    background: rgba(8,10,18,.95);
    border-bottom: 1px solid #252b3b;
    position: sticky;
    top: 0;
    z-index: 100;
}

.logo {
    font-size: 25px;
    font-weight: 800;
    letter-spacing: 1px;
}

.logo span {
    color: #55b7ff;
}

.tabs {
    display: flex;
    gap: 8px;
}

.tab {
    border: 1px solid #30384d;
    background: #101522;
    color: #aab4c8;
    padding: 12px 20px;
    border-radius: 10px;
    cursor: pointer;
    transition: .2s;
}

.tab:hover {
    border-color: #55b7ff;
    color: white;
}

.tab.active {
    background: #55b7ff;
    color: #06101a;
    font-weight: bold;
}

/* ================= PAGES ================= */

.page {
    display: none;
}

.page.active {
    display: block;
}

/* ================= GAME HEADER ================= */

.game-head {
    padding: 25px 35px 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
}

.game-title h1 {
    font-size: 29px;
    margin-bottom: 6px;
}

.game-title p {
    color: #8e98ad;
}

.budget-box {
    min-width: 300px;
    padding: 15px 20px;
    border: 1px solid #293248;
    border-radius: 14px;
    background: linear-gradient(145deg,#101624,#0b0e17);
}

.budget-top {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.budget-label {
    color: #8e98ad;
}

.budget-value {
    font-size: 22px;
    font-weight: bold;
}

.budget-value.good {
    color: #55e6a5;
}

.budget-value.bad {
    color: #ff6577;
}

.budget-line {
    height: 8px;
    background: #1e2534;
    border-radius: 20px;
    overflow: hidden;
}

.budget-fill {
    height: 100%;
    width: 0%;
    background: linear-gradient(90deg,#55b7ff,#8b65ff);
    transition: .3s;
}

/* ================= MAIN ================= */

.game {
    display: grid;
    grid-template-columns: minmax(450px, 1.05fr) minmax(500px, .95fr);
    gap: 25px;
    padding: 15px 35px 35px;
}

/* ================= PC AREA ================= */

.pc-area {
    background: linear-gradient(145deg,#0d111c,#080a10);
    border: 1px solid #252d40;
    border-radius: 20px;
    min-height: 700px;
    padding: 25px;
    position: relative;
    overflow: hidden;
}

.pc-area::before {
    content: "";
    position: absolute;
    width: 350px;
    height: 350px;
    border-radius: 50%;
    background: rgba(70,130,255,.07);
    filter: blur(70px);
    top: 150px;
    left: 100px;
}

.pc-title {
    text-align: center;
    color: #8994aa;
    margin-bottom: 10px;
    font-size: 14px;
    letter-spacing: 1px;
}

/* ================= CASE ================= */

.pc-case {
    width: 370px;
    height: 575px;
    margin: 20px auto 0;
    position: relative;
    border: 4px solid #4a5265;
    border-radius: 17px;
    background: linear-gradient(120deg,#171b27,#0c0f16);
    box-shadow:
        0 0 0 5px #080a0f,
        0 0 40px rgba(0,0,0,.8);
}

/* glass */
.pc-case::before {
    content: "";
    position: absolute;
    left: 8px;
    top: 8px;
    width: 245px;
    height: 551px;
    border: 2px solid #354158;
    border-radius: 10px;
    background:
        linear-gradient(115deg,rgba(255,255,255,.07),transparent 30%),
        rgba(30,45,65,.16);
    z-index: 10;
    pointer-events: none;
}

/* front panel */
.front-panel {
    position: absolute;
    right: 0;
    top: 0;
    width: 92px;
    height: 100%;
    background: linear-gradient(#151a26,#0b0e14);
    border-left: 1px solid #30384a;
    border-radius: 0 13px 13px 0;
}

.front-panel::after {
    content: "";
    position: absolute;
    top: 40px;
    left: 20px;
    width: 50px;
    height: 420px;
    background:
        repeating-linear-gradient(
            to bottom,
            #242b3b 0px,
            #242b3b 4px,
            transparent 4px,
            transparent 12px
        );
    opacity: .55;
}

/* power button */
.power-button {
    position: absolute;
    right: 27px;
    top: 17px;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: 2px solid #657087;
    z-index: 20;
}

.power-button::after {
    content: "";
    position: absolute;
    width: 12px;
    height: 16px;
    border: 2px solid #76849c;
    border-top-color: transparent;
    border-radius: 50%;
    left: 9px;
    top: 7px;
}

/* ================= COMPONENT POSITIONS ================= */

.part {
    position: absolute;
    opacity: 0;
    transform: scale(.7);
    transition: .45s cubic-bezier(.2,.8,.2,1);
    z-index: 5;
}

.part.installed {
    opacity: 1;
    transform: scale(1);
}

/* motherboard */
.motherboard {
    width: 220px;
    height: 330px;
    left: 20px;
    top: 100px;
    border-radius: 5px;
    background:
        linear-gradient(90deg,transparent 48%,rgba(80,120,80,.4) 49%,transparent 51%),
        linear-gradient(0deg,transparent 48%,rgba(80,120,80,.4) 49%,transparent 51%),
        #152a25;
    border: 2px solid #4e715f;
    box-shadow: inset 0 0 20px rgba(0,0,0,.7);
}

.motherboard .socket {
    position: absolute;
    left: 65px;
    top: 45px;
    width: 82px;
    height: 82px;
    background: #68717b;
    border: 7px solid #343b43;
    box-shadow: inset 0 0 0 5px #1a1d21;
}

.motherboard .slots {
    position: absolute;
    right: 17px;
    top: 40px;
    display: flex;
    gap: 5px;
}

.motherboard .slot {
    width: 9px;
    height: 125px;
    background: #121923;
    border: 1px solid #536078;
}

.motherboard .pcie {
    position: absolute;
    left: 20px;
    width: 175px;
    height: 12px;
    background: #101720;
    border: 1px solid #506174;
}

.motherboard .pcie:nth-child(1) {
    top: 160px;
}

.motherboard .pcie:nth-child(2) {
    top: 195px;
}

.motherboard .heatsink {
    position: absolute;
    width: 40px;
    height: 55px;
    background: linear-gradient(90deg,#505963,#252b31);
    right: 18px;
    bottom: 35px;
}

/* CPU */
.cpu {
    width: 70px;
    height: 70px;
    left: 96px;
    top: 144px;
    z-index: 8;
    background: #b7bdc4;
    border: 7px solid #747b84;
    box-shadow: 0 0 18px rgba(255,255,255,.18);
}

.cpu::before {
    content: "CPU";
    position: absolute;
    inset: 12px;
    background: #4b5158;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    font-weight: bold;
}

/* RAM */
.ram {
    width: 12px;
    height: 130px;
    top: 142px;
    background: linear-gradient(#303b50,#10151e);
    border: 1px solid #73809a;
    z-index: 7;
    box-shadow: 0 0 12px rgba(80,170,255,.4);
}

.ram::after {
    content: "";
    position: absolute;
    bottom: -4px;
    left: 1px;
    width: 8px;
    height: 5px;
    background: #c5a64b;
}

.ram1 { left: 161px; }
.ram2 { left: 177px; }
.ram3 { left: 193px; }
.ram4 { left: 209px; }

/* GPU */
.gpu {
    width: 195px;
    height: 82px;
    left: 34px;
    top: 265px;
    border-radius: 7px;
    background: linear-gradient(#353d4d,#161b25);
    border: 2px solid #68758c;
    z-index: 9;
    box-shadow: 0 8px 20px rgba(0,0,0,.6);
}

.gpu .fan {
    position: absolute;
    top: 14px;
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background:
        repeating-conic-gradient(#596273 0 15deg,#242a35 15deg 30deg);
    border: 4px solid #11151d;
}

.gpu .fan::after {
    content: "";
    position: absolute;
    width: 12px;
    height: 12px;
    background: #8c96a8;
    border-radius: 50%;
    left: 14px;
    top: 14px;
}

.gpu .fan:nth-child(1) { left: 18px; }
.gpu .fan:nth-child(2) { left: 74px; }
.gpu .fan:nth-child(3) { left: 130px; }

/* SSD */
.ssd {
    width: 115px;
    height: 28px;
    left: 75px;
    top: 220px;
    background: linear-gradient(90deg,#222b3c,#58687e);
    border: 2px solid #8998aa;
    border-radius: 3px;
    z-index: 8;
}

.ssd::after {
    content: "NVMe";
    position: absolute;
    right: 8px;
    top: 6px;
    font-size: 9px;
    color: #cbd5e4;
}

/* COOLER */
.cooler {
    width: 110px;
    height: 110px;
    left: 81px;
    top: 126px;
    border-radius: 50%;
    background:
        repeating-conic-gradient(
            #777f8b 0deg 15deg,
            #2c323a 15deg 30deg
        );
    border: 9px solid #343b46;
    z-index: 10;
    box-shadow: 0 0 15px rgba(80,160,255,.25);
}

.cooler::after {
    content: "";
    position: absolute;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: #1c232e;
    border: 5px solid #778397;
    left: 30px;
    top: 30px;
}

/* PSU */
.psu {
    width: 100px;
    height: 120px;
    left: 275px;
    bottom: 18px;
    background: linear-gradient(145deg,#303746,#11151d);
    border: 2px solid #5e697d;
    z-index: 6;
}

.psu::before {
    content: "";
    position: absolute;
    width: 62px;
    height: 62px;
    border: 5px dotted #8994a5;
    border-radius: 50%;
    left: 17px;
    top: 16px;
}

.psu::after {
    content: "POWER";
    position: absolute;
    font-size: 9px;
    left: 29px;
    bottom: 20px;
    color: #9ba7ba;
}

/* CASE fans */
.case-fans {
    position: absolute;
    right: 105px;
    top: 105px;
    z-index: 4;
}

.case-fan {
    width: 55px;
    height: 55px;
    margin-bottom: 18px;
    border-radius: 50%;
    border: 3px solid #414b5f;
    background:
        repeating-conic-gradient(#263142 0 20deg,#10151e 20deg 40deg);
}

/* cables */
.cable {
    position: absolute;
    width: 70px;
    height: 5px;
    background: #111;
    border-radius: 10px;
    z-index: 11;
}

.c1 {
    left: 215px;
    top: 205px;
    transform: rotate(25deg);
}

.c2 {
    left: 210px;
    top: 335px;
    transform: rotate(-20deg);
}

/* labels */
.part-label {
    position: absolute;
    background: rgba(0,0,0,.8);
    border: 1px solid #3e4a61;
    padding: 4px 7px;
    border-radius: 5px;
    font-size: 9px;
    opacity: 0;
    transition: .3s;
    z-index: 20;
}

.pc-case:hover .part.installed + .part-label {
    opacity: 1;
}

/* ================= RIGHT PANEL ================= */

.panel {
    min-width: 0;
}

.step-card {
    background: linear-gradient(145deg,#111624,#0b0e16);
    border: 1px solid #283146;
    border-radius: 20px;
    padding: 23px;
}

.step-top {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 18px;
}

.step-number {
    color: #55b7ff;
    font-size: 13px;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 5px;
}

.step-title {
    font-size: 25px;
}

.step-icon {
    width: 50px;
    height: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 12px;
    background: #182133;
    font-size: 25px;
}

.description {
    color: #a2acc0;
    line-height: 1.55;
    margin-bottom: 15px;
}

.why {
    padding: 13px 15px;
    background: rgba(65,145,255,.08);
    border-left: 3px solid #55b7ff;
    border-radius: 7px;
    color: #c8d4e9;
    margin-bottom: 20px;
    line-height: 1.45;
}

.why strong {
    color: #55b7ff;
}

/* ================= OPTIONS ================= */

.options-title {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.options-title span {
    color: #7f899c;
    font-size: 13px;
}

.options {
    display: grid;
    grid-template-columns: repeat(2,1fr);
    gap: 10px;
    max-height: 385px;
    overflow-y: auto;
    padding-right: 4px;
}

.options::-webkit-scrollbar {
    width: 5px;
}

.options::-webkit-scrollbar-thumb {
    background: #354058;
    border-radius: 10px;
}

.option {
    position: relative;
    border: 1px solid #293348;
    border-radius: 13px;
    padding: 14px;
    background: #0e131f;
    cursor: pointer;
    transition: .2s;
}

.option:hover {
    transform: translateY(-2px);
    border-color: #4c9fe0;
    background: #111a2a;
}

.option.selected {
    border-color: #55b7ff;
    box-shadow: 0 0 0 1px #55b7ff inset;
    background: #121e31;
}

.option.disabled {
    opacity: .35;
    cursor: not-allowed;
}

.option.disabled:hover {
    transform: none;
    border-color: #293348;
    background: #0e131f;
}

.tier {
    display: inline-block;
    font-size: 9px;
    padding: 4px 7px;
    border-radius: 5px;
    background: #202a3b;
    color: #91a3bd;
    margin-bottom: 8px;
    text-transform: uppercase;
}

.tier.premium {
    background: #302744;
    color: #c4a4ff;
}

.tier.ultra {
    background: #402d25;
    color: #ffc08c;
}

.option-name {
    font-weight: bold;
    margin-bottom: 6px;
    font-size: 14px;
}

.spec {
    color: #7e899e;
    font-size: 11px;
    line-height: 1.4;
    min-height: 32px;
}

.price {
    color: #55e6a5;
    font-size: 17px;
    font-weight: bold;
    margin-top: 10px;
}

.selected-mark {
    position: absolute;
    right: 10px;
    top: 10px;
    color: #55e6a5;
    opacity: 0;
}

.option.selected .selected-mark {
    opacity: 1;
}

/* ================= NAVIGATION ================= */

.navigation {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
    gap: 10px;
}

button {
    font-family: inherit;
}

.nav-btn {
    border: 1px solid #303a51;
    border-radius: 10px;
    padding: 13px 20px;
    background: #111724;
    color: white;
    cursor: pointer;
    font-weight: bold;
}

.nav-btn:hover {
    border-color: #55b7ff;
}

.nav-btn.primary {
    background: #55b7ff;
    color: #07111c;
    border-color: #55b7ff;
}

.nav-btn:disabled {
    opacity: .35;
    cursor: not-allowed;
}

/* ================= BUILD SUMMARY ================= */

.summary {
    margin-top: 15px;
    background: #0b0f18;
    border: 1px solid #252e42;
    border-radius: 15px;
    padding: 15px;
}

.summary h3 {
    font-size: 14px;
    margin-bottom: 10px;
}

.summary-list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 6px;
}

.summary-item {
    display: flex;
    justify-content: space-between;
    color: #7f8ba1;
    font-size: 11px;
}

.summary-item span:last-child {
    color: #c6d0df;
}

/* ================= FINAL ================= */

.final {
    display: none;
    text-align: center;
    padding: 35px;
    background: linear-gradient(145deg,#101827,#0b1019);
    border: 1px solid #32405a;
    border-radius: 20px;
}

.final.show {
    display: block;
}

.final-icon {
    font-size: 60px;
    margin-bottom: 15px;
}

.final h2 {
    font-size: 30px;
    margin-bottom: 8px;
}

.final p {
    color: #8f9aae;
}

.result-grid {
    display: grid;
    grid-template-columns: repeat(3,1fr);
    gap: 10px;
    margin: 25px 0;
}

.result-box {
    padding: 15px;
    background: #111827;
    border: 1px solid #29354a;
    border-radius: 10px;
}

.result-box small {
    display: block;
    color: #78859b;
    margin-bottom: 7px;
}

.result-box strong {
    font-size: 20px;
}

.score {
    font-size: 25px;
    color: #55e6a5;
    margin-bottom: 20px;
}

.power-btn {
    border: 0;
    border-radius: 12px;
    padding: 15px 30px;
    background: linear-gradient(90deg,#55b7ff,#8b65ff);
    color: white;
    font-weight: bold;
    cursor: pointer;
    font-size: 16px;
}

.power-btn:hover {
    transform: translateY(-2px);
}

/* ================= POWER EFFECT ================= */

.pc-case.powered {
    animation: pcGlow 1.5s infinite alternate;
}

.pc-case.powered .case-fan {
    animation: spin 1s linear infinite;
    box-shadow: 0 0 15px rgba(70,160,255,.7);
}

.pc-case.powered .gpu .fan {
    animation: spin 1s linear infinite;
}

.pc-case.powered .ram {
    box-shadow:
        0 0 10px #55b7ff,
        0 0 20px #8b65ff;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

@keyframes pcGlow {
    from {
        box-shadow:
            0 0 0 5px #080a0f,
            0 0 30px rgba(70,130,255,.15);
    }
    to {
        box-shadow:
            0 0 0 5px #080a0f,
            0 0 60px rgba(80,150,255,.45);
    }
}

/* ================= SECOND TAB ================= */

.empty-page {
    max-width: 900px;
    margin: 80px auto;
    padding: 50px;
    text-align: center;
    background: #101521;
    border: 1px solid #293248;
    border-radius: 20px;
}

.empty-page h2 {
    font-size: 30px;
    margin-bottom: 12px;
}

.empty-page p {
    color: #8994a8;
}

/* ================= RESPONSIVE ================= */

@media(max-width:1000px) {
    .game {
        grid-template-columns: 1fr;
    }

    .game-head {
        flex-direction: column;
        align-items: stretch;
    }

    .budget-box {
        min-width: 0;
    }
}

@media(max-width:600px) {
    header {
        padding: 0 15px;
    }

    .logo {
        font-size: 18px;
    }

    .tab {
        padding: 9px 12px;
    }

    .game {
        padding: 10px;
    }

    .pc-area {
        min-height: 600px;
    }

    .pc-case {
        transform: scale(.82);
        transform-origin: top center;
        margin-bottom: -80px;
    }

    .options {
        grid-template-columns: 1fr;
    }

    .result-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<header>
    <div class="logo">
        HARD<span>WARE</span> BUILDER
    </div>

    <div class="tabs">
        <button class="tab active" onclick="openTab('hardware', this)">
            🖥 Hardware
        </button>

        <button class="tab" onclick="openTab('second', this)">
            🔒 Вкладка 2
        </button>
    </div>
</header>


<!-- ===================================================== -->
<!-- HARDWARE -->
<!-- ===================================================== -->

<div id="hardware" class="page active">

    <div class="game-head">

        <div class="game-title">
            <h1>Собери свой компьютер</h1>
            <p>Выбирай комплектующие и собери ПК, не превысив бюджет.</p>
        </div>

        <div class="budget-box">

            <div class="budget-top">
                <span class="budget-label">
                    Бюджет игры
                </span>

                <span id="budgetText" class="budget-value good">
                    $4,500
                </span>
            </div>

            <div class="budget-line">
                <div id="budgetFill" class="budget-fill"></div>
            </div>

        </div>

    </div>


    <main class="game">

        <!-- ================= PC ================= -->

        <section class="pc-area">

            <div class="pc-title">
                ВАШ ПК • КОМПЛЕКТУЮЩИЕ УСТАНАВЛИВАЮТСЯ ПОЭТАПНО
            </div>

            <div class="pc-case" id="pcCase">

                <div class="front-panel"></div>
                <div class="power-button"></div>

                <!-- Motherboard -->
                <div id="visual-motherboard"
                     class="part motherboard">

                    <div class="socket"></div>

                    <div class="slots">
                        <div class="slot"></div>
                        <div class="slot"></div>
                        <div class="slot"></div>
                        <div class="slot"></div>
                    </div>

                    <div class="pcie"></div>
                    <div class="pcie"></div>

                    <div class="heatsink"></div>

                </div>


                <!-- CPU -->
                <div id="visual-cpu"
                     class="part cpu">
                </div>


                <!-- Cooler -->
                <div id="visual-cooler"
                     class="part cooler">
                </div>


                <!-- RAM -->
                <div id="visual-ram1" class="part ram ram1"></div>
                <div id="visual-ram2" class="part ram ram2"></div>
                <div id="visual-ram3" class="part ram ram3"></div>
                <div id="visual-ram4" class="part ram ram4"></div>


                <!-- GPU -->
                <div id="visual-gpu"
                     class="part gpu">

                    <div class="fan"></div>
                    <div class="fan"></div>
                    <div class="fan"></div>

                </div>


                <!-- SSD -->
                <div id="visual-ssd"
                     class="part ssd">
                </div>


                <!-- PSU -->
                <div id="visual-psu"
                     class="part psu">
                </div>


                <!-- Case fans -->
                <div class="case-fans">
                    <div class="case-fan"></div>
                    <div class="case-fan"></div>
                    <div class="case-fan"></div>
                </div>


                <!-- cables -->
                <div class="cable c1"></div>
                <div class="cable c2"></div>

            </div>

        </section>


        <!-- ================= CONTROL ================= -->

        <section class="panel">

            <div id="stepCard" class="step-card">

                <div class="step-top">

                    <div>
                        <div id="stepNumber"
                             class="step-number">
                            ШАГ 1 / 8
                        </div>

                        <h2 id="stepTitle"
                            class="step-title">
                            Материнская плата
                        </h2>
                    </div>

                    <div id="stepIcon"
                         class="step-icon">
                        🧩
                    </div>

                </div>


                <p id="description"
                   class="description">
                </p>


                <div class="why">
                    <strong>Зачем нужна?</strong>
                    <br>
                    <span id="whyText"></span>
                </div>


                <div class="options-title">
                    <strong>Выберите комплектующее</strong>

                    <span>
                        Чем дороже — тем выше уровень
                    </span>
                </div>


                <div id="options"
                     class="options">
                </div>


                <div class="navigation">

                    <button id="backBtn"
                            class="nav-btn"
                            onclick="previousStep()">
                        ← Назад
                    </button>

                    <button id="nextBtn"
                            class="nav-btn primary"
                            onclick="nextStep()">
                        Выбрать и дальше →
                    </button>

                </div>

            </div>


            <!-- SUMMARY -->

            <div class="summary">

                <h3>
                    📋 Ваша сборка
                </h3>

                <div id="summaryList"
                     class="summary-list">
                </div>

            </div>


            <!-- FINAL -->

            <div id="final"
                 class="final">

                <div class="final-icon">
                    🖥️
                </div>

                <h2>
                    ПК собран!
                </h2>

                <p>
                    Все основные комплектующие выбраны.
                </p>


                <div class="result-grid">

                    <div class="result-box">
                        <small>Потрачено</small>
                        <strong id="spentResult">
                            $0
                        </strong>
                    </div>

                    <div class="result-box">
                        <small>Осталось</small>
                        <strong id="leftResult">
                            $0
                        </strong>
                    </div>

                    <div class="result-box">
                        <small>Комплектующих</small>
                        <strong>
                            8 / 8
                        </strong>
                    </div>

                </div>


                <div class="score"
                     id="scoreText">
                    Оценка: 100 / 100
                </div>


                <button class="power-btn"
                        onclick="powerOn()">
                    ⚡ Запустить ПК
                </button>

                <br><br>

                <button class="nav-btn"
                        onclick="restartGame()">
                    🔄 Собрать заново
                </button>

            </div>

        </section>

    </main>

</div>


<!-- ===================================================== -->
<!-- SECOND TAB -->
<!-- ===================================================== -->

<div id="second"
     class="page">

    <div class="empty-page">

        <h2>
            🔒 Вторая вкладка
        </h2>

        <p>
            Здесь позже можно добавить следующую часть проекта.
            Например: тест знаний, 3D-сборку, сравнение комплектующих
            или мини-игру.
        </p>

    </div>

</div>


<script>

/* =========================================================
   GAME DATA
========================================================= */

const BUDGET = 4500;

const components = [

    {
        id: "motherboard",
        title: "Материнская плата",
        icon: "🧩",

        description:
        "Главная плата компьютера. К ней подключаются процессор, оперативная память, видеокарта, накопители и другие устройства.",

        why:
        "Она соединяет все основные комплектующие между собой и позволяет им работать как единая система.",

        options: [

            {
                name: "ASRock B650M",
                spec: "AM5 • DDR5 • mATX • 2× M.2",
                price: 130,
                tier: "Бюджет"
            },

            {
                name: "MSI B650 Gaming",
                spec: "AM5 • DDR5 • ATX • Wi-Fi",
                price: 190,
                tier: "Бюджет"
            },

            {
                name: "Gigabyte B650 AORUS",
                spec: "AM5 • DDR5 • ATX • 3× M.2",
                price: 260,
                tier: "Средний"
            },

            {
                name: "ASUS TUF B650",
                spec: "AM5 • DDR5 • Wi-Fi • ATX",
                price: 320,
                tier: "Средний"
            },

            {
                name: "MSI X670E Carbon",
                spec: "AM5 • DDR5 • PCIe 5.0 • Wi-Fi",
                price: 390,
                tier: "Премиум"
            },

            {
                name: "ASUS ROG X670E",
                spec: "AM5 • DDR5 • PCIe 5.0 • ATX",
                price: 470,
                tier: "Премиум"
            },

            {
                name: "ASUS ROG Crosshair",
                spec: "AM5 • DDR5 • топовый VRM • Wi-Fi",
                price: 580,
                tier: "Ultra"
            },

            {
                name: "MSI MEG X670E",
                spec: "AM5 • DDR5 • расширенные возможности",
                price: 650,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "cpu",
        title: "Процессор",
        icon: "🧠",

        description:
        "Процессор, или CPU, выполняет вычисления и обрабатывает команды программ.",

        why:
        "Без процессора компьютер не сможет выполнять программы, игры и другие задачи.",

        options: [

            {
                name: "Ryzen 5 7600",
                spec: "6 ядер • 12 потоков • AM5",
                price: 190,
                tier: "Бюджет"
            },

            {
                name: "Ryzen 7 7700",
                spec: "8 ядер • 16 потоков • AM5",
                price: 280,
                tier: "Средний"
            },

            {
                name: "Ryzen 7 7800X3D",
                spec: "8 ядер • 16 потоков • 3D Cache",
                price: 390,
                tier: "Средний"
            },

            {
                name: "Ryzen 9 7900X",
                spec: "12 ядер • 24 потока • AM5",
                price: 440,
                tier: "Премиум"
            },

            {
                name: "Ryzen 9 7950X",
                spec: "16 ядер • 32 потока • AM5",
                price: 560,
                tier: "Премиум"
            },

            {
                name: "Ryzen 9 7950X3D",
                spec: "16 ядер • 32 потока • 3D Cache",
                price: 650,
                tier: "Ultra"
            },

            {
                name: "Ryzen 9 Creator",
                spec: "16 ядер • 32 потока • усиленный режим",
                price: 760,
                tier: "Ultra"
            },

            {
                name: "Ryzen Extreme",
                spec: "16 ядер • 32 потока • максимальный класс",
                price: 850,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "cooler",
        title: "Охлаждение CPU",
        icon: "❄️",

        description:
        "Система охлаждения отводит тепло от процессора.",

        why:
        "Во время работы CPU сильно нагревается. Охлаждение помогает поддерживать нормальную температуру.",

        options: [

            {
                name: "DeepCool AG400",
                spec: "Башенный кулер • 120 мм",
                price: 35,
                tier: "Бюджет"
            },

            {
                name: "DeepCool AK400",
                spec: "4 тепловые трубки • 120 мм",
                price: 50,
                tier: "Бюджет"
            },

            {
                name: "Thermalright Peerless",
                spec: "Dual Tower • 2 вентилятора",
                price: 75,
                tier: "Средний"
            },

            {
                name: "DeepCool AK620",
                spec: "Dual Tower • 6 тепловых трубок",
                price: 90,
                tier: "Средний"
            },

            {
                name: "Arctic Liquid Freezer",
                spec: "240 мм • жидкостное охлаждение",
                price: 125,
                tier: "Премиум"
            },

            {
                name: "NZXT Kraken 240",
                spec: "240 мм • AIO • дисплей",
                price: 160,
                tier: "Премиум"
            },

            {
                name: "Corsair H150i",
                spec: "360 мм • AIO",
                price: 210,
                tier: "Ultra"
            },

            {
                name: "ROG Ryujin",
                spec: "360 мм • премиальная СЖО",
                price: 270,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "ram",
        title: "Оперативная память",
        icon: "⚡",

        description:
        "Оперативная память, или RAM, временно хранит данные, которые прямо сейчас используются компьютером.",

        why:
        "Чем больше подходящей оперативной памяти, тем комфортнее компьютер работает с несколькими программами и большими задачами.",

        options: [

            {
                name: "16 GB DDR5",
                spec: "2×8 GB • 5200 MHz",
                price: 55,
                tier: "Бюджет"
            },

            {
                name: "32 GB DDR5",
                spec: "2×16 GB • 5600 MHz",
                price: 85,
                tier: "Бюджет"
            },

            {
                name: "32 GB DDR5 Gaming",
                spec: "2×16 GB • 6000 MHz • RGB",
                price: 110,
                tier: "Средний"
            },

            {
                name: "64 GB DDR5",
                spec: "2×32 GB • 6000 MHz",
                price: 170,
                tier: "Средний"
            },

            {
                name: "64 GB DDR5 RGB",
                spec: "2×32 GB • 6400 MHz • RGB",
                price: 210,
                tier: "Премиум"
            },

            {
                name: "96 GB DDR5",
                spec: "2×48 GB • 6000 MHz",
                price: 270,
                tier: "Премиум"
            },

            {
                name: "128 GB DDR5",
                spec: "4×32 GB • 5600 MHz",
                price: 360,
                tier: "Ultra"
            },

            {
                name: "128 GB DDR5 Pro",
                spec: "4×32 GB • усиленный профиль",
                price: 440,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "gpu",
        title: "Видеокарта",
        icon: "🎮",

        description:
        "GPU отвечает за обработку графики и создание изображения, которое отображается на мониторе.",

        why:
        "Особенно важна для игр, 3D-графики, монтажа видео и других графически сложных задач.",

        options: [

            {
                name: "RTX 4060",
                spec: "8 GB VRAM • Gaming",
                price: 300,
                tier: "Бюджет"
            },

            {
                name: "RTX 4060 Ti",
                spec: "8 GB VRAM • Gaming",
                price: 420,
                tier: "Бюджет"
            },

            {
                name: "RTX 4070 Super",
                spec: "12 GB VRAM • 1440p",
                price: 600,
                tier: "Средний"
            },

            {
                name: "RTX 4070 Ti Super",
                spec: "16 GB VRAM • 1440p/4K",
                price: 800,
                tier: "Средний"
            },

            {
                name: "RTX 4080 Super",
                spec: "16 GB VRAM • High-End",
                price: 1000,
                tier: "Премиум"
            },

            {
                name: "RX 7900 XTX",
                spec: "24 GB VRAM • High-End",
                price: 1050,
                tier: "Премиум"
            },

            {
                name: "RTX 4090",
                spec: "24 GB VRAM • Extreme Gaming",
                price: 1500,
                tier: "Ultra"
            },

            {
                name: "RTX 4090 OC",
                spec: "24 GB VRAM • Factory OC",
                price: 1700,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "ssd",
        title: "SSD накопитель",
        icon: "💾",

        description:
        "SSD используется для хранения операционной системы, программ, игр, фотографий и других файлов.",

        why:
        "SSD намного быстрее классического HDD и помогает быстрее загружать систему и программы.",

        options: [

            {
                name: "500 GB NVMe",
                spec: "PCIe 4.0 • до 5000 MB/s",
                price: 40,
                tier: "Бюджет"
            },

            {
                name: "1 TB NVMe",
                spec: "PCIe 4.0 • до 7000 MB/s",
                price: 65,
                tier: "Бюджет"
            },

            {
                name: "2 TB NVMe",
                spec: "PCIe 4.0 • до 7000 MB/s",
                price: 110,
                tier: "Средний"
            },

            {
                name: "2 TB Gaming NVMe",
                spec: "PCIe 4.0 • высокий ресурс",
                price: 145,
                tier: "Средний"
            },

            {
                name: "4 TB NVMe",
                spec: "PCIe 4.0 • большой объём",
                price: 240,
                tier: "Премиум"
            },

            {
                name: "4 TB Gen5",
                spec: "PCIe 5.0 • высокая скорость",
                price: 330,
                tier: "Премиум"
            },

            {
                name: "8 TB NVMe",
                spec: "PCIe 4.0 • огромный объём",
                price: 520,
                tier: "Ultra"
            },

            {
                name: "8 TB Gen5",
                spec: "PCIe 5.0 • Extreme",
                price: 700,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "psu",
        title: "Блок питания",
        icon: "🔌",

        description:
        "Блок питания преобразует электричество из розетки и подаёт необходимое питание всем компонентам компьютера.",

        why:
        "Мощности блока питания должно хватать для всех компонентов системы.",

        options: [

            {
                name: "650W Bronze",
                spec: "650 Вт • 80+ Bronze",
                price: 65,
                tier: "Бюджет"
            },

            {
                name: "750W Gold",
                spec: "750 Вт • 80+ Gold",
                price: 90,
                tier: "Бюджет"
            },

            {
                name: "850W Gold",
                spec: "850 Вт • Modular",
                price: 125,
                tier: "Средний"
            },

            {
                name: "1000W Gold",
                spec: "1000 Вт • Modular",
                price: 170,
                tier: "Средний"
            },

            {
                name: "1000W Platinum",
                spec: "1000 Вт • 80+ Platinum",
                price: 220,
                tier: "Премиум"
            },

            {
                name: "1200W Platinum",
                spec: "1200 Вт • Modular",
                price: 270,
                tier: "Премиум"
            },

            {
                name: "1300W Titanium",
                spec: "1300 Вт • Titanium",
                price: 350,
                tier: "Ultra"
            },

            {
                name: "1600W Titanium",
                spec: "1600 Вт • Extreme",
                price: 450,
                tier: "Ultra"
            }

        ]
    },


    {
        id: "case",
        title: "Корпус",
        icon: "🖥️",

        description:
        "Корпус содержит и защищает внутренние комплектующие компьютера.",

        why:
        "Он также влияет на охлаждение, расположение деталей, количество вентиляторов и внешний вид ПК.",

        options: [

            {
                name: "Basic ATX Case",
                spec: "ATX • 2 вентилятора",
                price: 60,
                tier: "Бюджет"
            },

            {
                name: "DeepCool CC560",
                spec: "ATX • 4 вентилятора",
                price: 75,
                tier: "Бюджет"
            },

            {
                name: "Montech Air 903",
                spec: "ATX • Mesh • 4 вентилятора",
                price: 100,
                tier: "Средний"
            },

            {
                name: "NZXT H5 Flow",
                spec: "ATX • стекло • Mesh",
                price: 120,
                tier: "Средний"
            },

            {
                name: "Corsair 4000D",
                spec: "ATX • Tempered Glass",
                price: 130,
                tier: "Премиум"
            },

            {
                name: "Lian Li O11",
                spec: "ATX • панорамное стекло",
                price: 170,
                tier: "Премиум"
            },

            {
                name: "Hyte Y70",
                spec: "ATX • панорамное стекло",
                price: 230,
                tier: "Ultra"
            },

            {
                name: "Premium Showcase",
                spec: "ATX • стекло • RGB • 10 вентиляторов",
                price: 300,
                tier: "Ultra"
            }

        ]
    }

];


/* =========================================================
   VARIABLES
========================================================= */

let currentStep = 0;

let selected = new Array(components.length).fill(null);


/* =========================================================
   GET TOTAL
========================================================= */

function getSpent() {

    return selected.reduce((total, item) => {

        if (!item) return total;

        return total + item.price;

    }, 0);
}


/* =========================================================
   FORMAT MONEY
========================================================= */

function money(value) {

    return "$" + value.toLocaleString("en-US");

}


/* =========================================================
   UPDATE BUDGET
========================================================= */

function updateBudget() {

    const spent = getSpent();

    const remaining = BUDGET - spent;

    const percent = Math.min(
        100,
        Math.max(0, (spent / BUDGET) * 100)
    );

    document.getElementById("budgetText").textContent =
        money(remaining);

    const budgetText =
        document.getElementById("budgetText");

    budgetText.classList.toggle(
        "good",
        remaining >= 0
    );

    budgetText.classList.toggle(
        "bad",
        remaining < 0
    );

    document.getElementById("budgetFill").style.width =
        percent + "%";

    updateSummary();
}


/* =========================================================
   RENDER STEP
========================================================= */

function renderStep() {

    const component = components[currentStep];

    document.getElementById("stepNumber").textContent =
        `ШАГ ${currentStep + 1} / ${components.length}`;

    document.getElementById("stepTitle").textContent =
        component.title;

    document.getElementById("stepIcon").textContent =
        component.icon;

    document.getElementById("description").textContent =
        component.description;

    document.getElementById("whyText").textContent =
        component.why;


    const optionsBox =
        document.getElementById("options");

    optionsBox.innerHTML = "";


    const spent = getSpent();

    const currentSelected =
        selected[currentStep];

    const spentWithoutCurrent =
        currentSelected
            ? spent - currentSelected.price
            : spent;


    component.options.forEach((option, index) => {

        const canAfford =
            spentWithoutCurrent + option.price <= BUDGET;


        const card =
            document.createElement("div");

        card.className = "option";


        if (!canAfford) {

            card.classList.add("disabled");

        }


        if (
            currentSelected &&
            currentSelected.name === option.name
        ) {

            card.classList.add("selected");

        }


        let tierClass = "";

        if (option.tier === "Премиум") {

            tierClass = "premium";

        }

        if (option.tier === "Ultra") {

            tierClass = "ultra";

        }


        card.innerHTML = `

            <div class="tier ${tierClass}">
                ${option.tier}
            </div>

            <div class="option-name">
                ${option.name}
            </div>

            <div class="spec">
                ${option.spec}
            </div>

            <div class="price">
                ${money(option.price)}
            </div>

            <div class="selected-mark">
                ✓
            </div>

        `;


        if (canAfford) {

            card.onclick = () => {

                selectOption(index);

            };

        }


        optionsBox.appendChild(card);

    });


    document.getElementById("backBtn").disabled =
        currentStep === 0;


    const nextButton =
        document.getElementById("nextBtn");

    if (currentStep === components.length - 1) {

        nextButton.textContent =
            "Завершить сборку ✓";

    } else {

        nextButton.textContent =
            "Выбрать и дальше →";

    }


    updateSummary();

}


/* =========================================================
   SELECT
========================================================= */

function selectOption(index) {

    const component =
        components[currentStep];

    const option =
        component.options[index];


    const spent =
        getSpent();

    const old =
        selected[currentStep];

    const spentWithoutCurrent =
        old
            ? spent - old.price
            : spent;


    if (
        spentWithoutCurrent + option.price >
        BUDGET
    ) {

        alert(
            "Эта деталь выходит за пределы бюджета."
        );

        return;

    }


    selected[currentStep] = option;


    installVisual(component.id);


    renderStep();

    updateBudget();

}


/* =========================================================
   INSTALL VISUAL
========================================================= */

function installVisual(id) {

    if (id === "motherboard") {

        document
            .getElementById("visual-motherboard")
            .classList.add("installed");

    }


    if (id === "cpu") {

        document
            .getElementById("visual-cpu")
            .classList.add("installed");

    }


    if (id === "cooler") {

        document
            .getElementById("visual-cooler")
            .classList.add("installed");

    }


    if (id === "ram") {

        for (let i = 1; i <= 4; i++) {

            document
                .getElementById("visual-ram" + i)
                .classList.add("installed");

        }

    }


    if (id === "gpu") {

        document
            .getElementById("visual-gpu")
            .classList.add("installed");

    }


    if (id === "ssd") {

        document
            .getElementById("visual-ssd")
            .classList.add("installed");

    }


    if (id === "psu") {

        document
            .getElementById("visual-psu")
            .classList.add("installed");

    }

}


/* =========================================================
   SUMMARY
========================================================= */

function updateSummary() {

    const box =
        document.getElementById("summaryList");

    box.innerHTML = "";


    components.forEach((component, index) => {

        const item =
            selected[index];

        const row =
            document.createElement("div");

        row.className =
            "summary-item";


        row.innerHTML = `

            <span>
                ${component.title}
            </span>

            <span>
                ${
                    item
                        ? money(item.price)
                        : "—"
                }
            </span>

        `;


        box.appendChild(row);

    });

}


/* =========================================================
   NEXT
========================================================= */

function nextStep() {

    if (!selected[currentStep]) {

        alert(
            "Сначала выберите комплектующее."
        );

        return;

    }


    if (
        currentStep <
        components.length - 1
    ) {

        currentStep++;

        renderStep();

        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });

    } else {

        finishGame();

    }

}


/* =========================================================
   PREVIOUS
========================================================= */

function previousStep() {

    if (currentStep > 0) {

        currentStep--;

        renderStep();

    }

}


/* =========================================================
   FINISH
========================================================= */

function finishGame() {

    const allSelected =
        selected.every(item => item !== null);


    if (!allSelected) {

        alert(
            "Выберите все комплектующие."
        );

        return;

    }


    const spent =
        getSpent();

    const remaining =
        BUDGET - spent;


    document.getElementById("spentResult")
        .textContent =
        money(spent);


    document.getElementById("leftResult")
        .textContent =
        money(remaining);


    /*
        Игровая оценка.
        Чем рациональнее использован бюджет,
        тем выше оценка.
    */

    let score =
        Math.round(
            100 - (remaining / BUDGET) * 30
        );


    score =
        Math.max(
            70,
            Math.min(100, score)
        );


    document.getElementById("scoreText")
        .textContent =
        `Игровая оценка: ${score} / 100`;


    document.getElementById("stepCard")
        .style.display = "none";


    document.getElementById("final")
        .classList.add("show");


    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });

}


/* =========================================================
   POWER
========================================================= */

function powerOn() {

    const pc =
        document.getElementById("pcCase");

    pc.classList.add("powered");


    const button =
        document.querySelector(".power-btn");

    button.textContent =
        "🟢 ПК ЗАПУЩЕН";

}


/* =========================================================
   RESTART
========================================================= */

function restartGame() {

    currentStep = 0;

    selected =
        new Array(components.length)
        .fill(null);


    document
        .querySelectorAll(".part")
        .forEach(part => {

            part.classList.remove("installed");

        });


    document
        .getElementById("pcCase")
        .classList.remove("powered");


    document.getElementById("stepCard")
        .style.display = "block";


    document.getElementById("final")
        .classList.remove("show");


    document.querySelector(".power-btn")
        .textContent =
        "⚡ Запустить ПК";


    renderStep();

    updateBudget();

}


/* =========================================================
   TABS
========================================================= */

function openTab(page, button) {

    document
        .querySelectorAll(".page")
        .forEach(p => {

            p.classList.remove("active");

        });


    document
        .getElementById(page)
        .classList.add("active");


    document
        .querySelectorAll(".tab")
        .forEach(tab => {

            tab.classList.remove("active");

        });


    button.classList.add("active");

}


/* =========================================================
   START
========================================================= */

renderStep();

updateBudget();

</script>

</body>
</html>
