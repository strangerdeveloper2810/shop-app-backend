package com.project.shopapp.seeders;

import com.github.javafaker.Faker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

@Component
@Profile("seed")
@RequiredArgsConstructor
@Slf4j
public class DatabaseSeeder implements CommandLineRunner {
    private final DataSource dataSource;

    private static final int TOTAL_PRODUCTS = 300_000;
    private static final int BATCH_SIZE = 5_000;
    private final Random random = new Random(42);
    private final Faker faker = new Faker(new Locale("vi"));

    // ===================== CATEGORY DEFINITIONS =====================
    private static final String[] CATEGORY_NAMES = {
        "Điện thoại", "Laptop", "Tablet", "Smartwatch", "Tai nghe",
        "Phụ kiện điện thoại", "Phụ kiện laptop", "Loa", "Sạc dự phòng", "Camera",
        "Tivi", "Máy tính bàn", "Bàn phím", "Chuột", "Màn hình",
        "Card đồ họa", "Ổ cứng & SSD", "RAM", "Thiết bị mạng", "Máy in",
        "Máy chơi game", "Phụ kiện gaming", "Máy giặt", "Tủ lạnh", "Điều hòa",
        "Máy lọc nước", "Máy lọc không khí", "Robot hút bụi", "Nồi cơm điện", "Bếp từ & Bếp điện",
        "Lò vi sóng", "Nồi chiên không dầu", "Quần áo nam", "Quần áo nữ", "Giày dép nam",
        "Giày dép nữ", "Túi xách & Balo", "Đồng hồ thời trang", "Trang sức", "Kính mắt",
        "Nước hoa", "Mỹ phẩm & Skincare", "Chăm sóc cá nhân", "Thực phẩm chức năng", "Đồ thể thao",
        "Xe đạp", "Đồ dùng gia đình", "Nội thất", "Sách", "Đồ chơi trẻ em"
    };

    // Products per category (sums to 300,000)
    private static final int[] PRODUCTS_PER_CATEGORY = {
        18000, 14000, 8000, 6000, 9000,   // 1-5
        10000, 6000, 5000, 5000, 5000,     // 6-10
        6000, 5000, 5000, 5000, 5000,      // 11-15
        4000, 5000, 4000, 4000, 3000,      // 16-20
        5000, 6000, 5000, 5000, 5000,      // 21-25
        3000, 3000, 3000, 3000, 3000,      // 26-30
        3000, 4000, 14000, 14000, 8000,    // 31-35
        8000, 6000, 5000, 5000, 4000,      // 36-40
        5000, 8000, 5000, 5000, 6000,      // 41-45
        4000, 5000, 5000, 8000, 5000       // 46-50
    };

    // ===================== BRAND DATA PER CATEGORY =====================
    private static final String[][] BRANDS = {
        /* 1  Điện thoại */       {"Apple iPhone", "Samsung Galaxy", "Xiaomi", "OPPO", "Vivo", "Realme", "OnePlus", "Google Pixel", "Huawei", "Nokia", "Asus ROG Phone", "Sony Xperia", "Motorola", "Honor", "TCL", "Nothing Phone"},
        /* 2  Laptop */           {"Dell", "HP", "Lenovo", "Asus", "Acer", "MSI", "Apple MacBook", "LG Gram", "Huawei MateBook", "Microsoft Surface", "Gigabyte", "Razer", "Samsung Galaxy Book", "Fujitsu", "Toshiba Dynabook"},
        /* 3  Tablet */           {"Apple iPad", "Samsung Galaxy Tab", "Xiaomi Pad", "Lenovo Tab", "Huawei MatePad", "OPPO Pad", "Realme Pad", "Nokia Tab", "TCL Tab", "Amazon Fire HD"},
        /* 4  Smartwatch */       {"Apple Watch", "Samsung Galaxy Watch", "Garmin", "Xiaomi Watch", "Huawei Watch", "Amazfit", "Fitbit", "OPPO Watch", "Fossil", "Casio G-Shock"},
        /* 5  Tai nghe */         {"Sony", "Apple AirPods", "Samsung", "JBL", "Bose", "Sennheiser", "Audio-Technica", "Jabra", "Beats", "Anker Soundcore", "Marshall", "Skullcandy", "Xiaomi", "HyperX", "SteelSeries"},
        /* 6  Phụ kiện ĐT */     {"Anker", "Baseus", "Ugreen", "Spigen", "OtterBox", "Belkin", "Samsung", "Apple", "Xiaomi", "PISEN", "Mophie", "Ringke", "Nillkin", "ESR", "Torras"},
        /* 7  Phụ kiện Laptop */  {"Ugreen", "Anker", "Baseus", "Belkin", "Targus", "Logitech", "HyperDrive", "Satechi", "Dell", "HP", "Lenovo", "ASUS", "Twelve South", "Rain Design"},
        /* 8  Loa */              {"JBL", "Sony", "Bose", "Marshall", "Harman Kardon", "Bang & Olufsen", "Ultimate Ears", "Anker Soundcore", "Xiaomi", "LG", "Samsung", "Edifier", "Creative"},
        /* 9  Sạc dự phòng */     {"Anker", "Baseus", "Xiaomi", "Samsung", "PISEN", "Romoss", "Ugreen", "Belkin", "RAVPower", "Mophie", "ZMI", "Energizer", "Yoobao"},
        /* 10 Camera */           {"Canon", "Sony", "Nikon", "Fujifilm", "Panasonic", "Olympus", "GoPro", "DJI", "Leica", "Ricoh", "Hasselblad", "Insta360", "Sigma"},
        /* 11 Tivi */             {"Samsung", "LG", "Sony", "TCL", "Xiaomi", "Hisense", "Panasonic", "Toshiba", "Casper", "Sharp", "Coocaa", "Philips"},
        /* 12 Máy tính bàn */     {"Dell", "HP", "Lenovo", "Asus", "Acer", "MSI", "Apple iMac", "Intel NUC", "Beelink", "MinisForum", "CyberPowerPC", "NZXT"},
        /* 13 Bàn phím */         {"Logitech", "Razer", "Corsair", "SteelSeries", "HyperX", "Keychron", "Akko", "Leopold", "Ducky", "Royal Kludge", "FL Esports", "Dareu", "E-Dra", "Newmen"},
        /* 14 Chuột */            {"Logitech", "Razer", "Corsair", "SteelSeries", "HyperX", "Pulsar", "Lamzu", "Zowie", "Endgame Gear", "Glorious", "Dareu", "E-Dra", "Newmen", "Rapoo"},
        /* 15 Màn hình */         {"Dell", "LG", "Samsung", "Asus", "Acer", "BenQ", "ViewSonic", "MSI", "AOC", "Gigabyte", "Philips", "HP", "Xiaomi", "Lenovo"},
        /* 16 Card đồ họa */      {"NVIDIA GeForce", "AMD Radeon", "Asus ROG Strix", "MSI Gaming", "Gigabyte Aorus", "EVGA", "Zotac", "Sapphire", "PowerColor", "PNY", "Inno3D", "Galax"},
        /* 17 Ổ cứng & SSD */     {"Samsung", "Western Digital", "Seagate", "Kingston", "Crucial", "SanDisk", "Toshiba", "Intel", "Corsair", "ADATA", "Transcend", "Lexar"},
        /* 18 RAM */              {"Kingston", "Corsair", "G.Skill", "Crucial", "Samsung", "TeamGroup", "ADATA", "Patriot", "PNY", "Lexar"},
        /* 19 Thiết bị mạng */    {"TP-Link", "Asus", "Netgear", "Linksys", "D-Link", "Tenda", "Ubiquiti", "MikroTik", "Xiaomi", "Mercusys", "Ruijie"},
        /* 20 Máy in */           {"HP", "Canon", "Epson", "Brother", "Xerox", "Samsung", "Ricoh", "Kyocera", "Pantum", "Fuji Xerox"},
        /* 21 Máy chơi game */    {"Sony PlayStation", "Microsoft Xbox", "Nintendo", "Valve Steam Deck", "Asus ROG Ally", "Lenovo Legion Go", "MSI Claw", "Razer Edge", "Logitech G Cloud"},
        /* 22 Phụ kiện gaming */  {"Razer", "SteelSeries", "HyperX", "Corsair", "Logitech G", "ASUS ROG", "MSI", "Elgato", "NZXT", "Cooler Master", "Thermaltake", "DXRacer"},
        /* 23 Máy giặt */         {"Samsung", "LG", "Electrolux", "Toshiba", "Panasonic", "Aqua", "Sharp", "Casper", "Midea", "Whirlpool", "Bosch", "Beko"},
        /* 24 Tủ lạnh */          {"Samsung", "LG", "Panasonic", "Toshiba", "Electrolux", "Sharp", "Hitachi", "Aqua", "Casper", "Midea", "Beko", "Bosch"},
        /* 25 Điều hòa */         {"Daikin", "Panasonic", "Samsung", "LG", "Toshiba", "Mitsubishi", "Sharp", "Casper", "Midea", "Gree", "Aqua", "Electrolux"},
        /* 26 Máy lọc nước */     {"Kangaroo", "Karofi", "AO Smith", "Sunhouse", "Mutosi", "Panasonic", "Mitsubishi Cleansui", "Coway", "Pureit", "Aqua"},
        /* 27 Máy lọc KK */      {"Xiaomi", "Samsung", "Panasonic", "Sharp", "Coway", "Daikin", "LG", "Dyson", "Levoit", "Winix", "BlueAir"},
        /* 28 Robot hút bụi */    {"Roborock", "Ecovacs", "iRobot Roomba", "Xiaomi", "Dreame", "Samsung", "Dyson", "Eufy", "Roidmi", "Liectroux"},
        /* 29 Nồi cơm điện */     {"Toshiba", "Panasonic", "Tiger", "Zojirushi", "Cuckoo", "Sharp", "Sunhouse", "Philips", "Midea", "Electrolux", "Tefal"},
        /* 30 Bếp từ */           {"Bosch", "Electrolux", "Sunhouse", "Kangaroo", "Midea", "Panasonic", "Hafele", "Malloca", "Faster", "Teka", "Bluestone"},
        /* 31 Lò vi sóng */       {"Samsung", "Panasonic", "Sharp", "LG", "Electrolux", "Toshiba", "Midea", "Whirlpool", "Bluestone", "Sunhouse"},
        /* 32 Nồi chiên KD */     {"Philips", "Xiaomi", "Lock&Lock", "Tefal", "Sunhouse", "Kangaroo", "Midea", "Rapido", "Kalux", "Cosori", "Ninja", "BlueStone"},
        /* 33 Quần áo nam */      {"Uniqlo", "Zara", "H&M", "Nike", "Adidas", "Puma", "Levi's", "Calvin Klein", "Tommy Hilfiger", "Owen", "Aristino", "Canifa", "Routine", "Coolmate", "Hades", "Yame"},
        /* 34 Quần áo nữ */       {"Uniqlo", "Zara", "H&M", "Mango", "COS", "Elise", "IVY moda", "Canifa", "NEM", "Dottie", "Jockey", "Couple TX", "Marc Fashion", "Ivy Moda"},
        /* 35 Giày dép nam */     {"Nike", "Adidas", "Puma", "New Balance", "Converse", "Vans", "Dr. Martens", "Birkenstock", "Biti's", "Ananas", "Bitis Hunter", "Asics", "Reebok", "Fila", "Skechers"},
        /* 36 Giày dép nữ */      {"Nike", "Adidas", "Puma", "New Balance", "Converse", "Vans", "Charles & Keith", "Aldo", "Steve Madden", "Juno", "Vascara", "Biti's", "Melissa", "Skechers"},
        /* 37 Túi xách & Balo */  {"Samsonite", "Herschel", "The North Face", "Adidas", "Nike", "Jansport", "Fjallraven", "Crumpler", "Pacsafe", "Peak Design", "Tomtoc", "Balo Sakos"},
        /* 38 Đồng hồ TT */      {"Casio", "Citizen", "Seiko", "Orient", "Tissot", "Daniel Wellington", "Fossil", "Michael Kors", "Timex", "Emporio Armani", "Movado", "Hamilton"},
        /* 39 Trang sức */        {"PNJ", "DOJI", "SJC", "Pandora", "Swarovski", "Cartier", "Tiffany & Co", "Bảo Tín Minh Châu", "Huy Thanh", "Tierra Diamond"},
        /* 40 Kính mắt */         {"Ray-Ban", "Oakley", "Gucci", "Prada", "Dior", "Tom Ford", "Gentle Monster", "Burberry", "Versace", "Police", "Bolon", "Coastal"},
        /* 41 Nước hoa */         {"Chanel", "Dior", "Versace", "Gucci", "YSL", "Tom Ford", "Jo Malone", "Calvin Klein", "Dolce & Gabbana", "Prada", "Hermès", "Bvlgari", "Montblanc", "Hugo Boss"},
        /* 42 Mỹ phẩm */         {"L'Oréal", "Maybelline", "MAC", "La Roche-Posay", "Innisfree", "The Ordinary", "CeraVe", "Laneige", "SK-II", "Sulwhasoo", "Anessa", "Bioderma", "Vichy", "Some By Mi", "Cosrx"},
        /* 43 CSCC */             {"Oral-B", "Philips Sonicare", "Gillette", "Braun", "Dyson", "Panasonic", "Waterpik", "Dove", "Nivea", "Cetaphil", "Neutrogena", "Head & Shoulders"},
        /* 44 TPCN */             {"DHC", "Blackmores", "Kirkland", "Nature Made", "Swisse", "GNC", "Now Foods", "Centrum", "Pharmacity", "Doppelherz", "Solgar", "Nutrilite"},
        /* 45 Đồ thể thao */     {"Nike", "Adidas", "Puma", "Under Armour", "Yonex", "Li-Ning", "Mizuno", "Decathlon", "Speedo", "Arena", "Asics", "The North Face"},
        /* 46 Xe đạp */           {"Giant", "Trek", "Specialized", "Cannondale", "Merida", "Trinx", "Java", "Twitter", "Fornix", "Maruishi", "Thống Nhất", "Asama"},
        /* 47 Đồ dùng GĐ */      {"Lock&Lock", "Tupperware", "IKEA", "Sunhouse", "Kangaroo", "Goldsun", "Happy Cook", "Tefal", "Corelle", "Luminarc", "Bát Tràng"},
        /* 48 Nội thất */         {"IKEA", "Hòa Phát", "Xuân Hòa", "Nội thất 190", "The Gioi Noi That", "Moho", "JYSK", "Nitori", "Ashley", "Muji", "DongA Furniture"},
        /* 49 Sách */             {"NXB Kim Đồng", "NXB Trẻ", "NXB Tổng Hợp", "Alpha Books", "First News", "Nhã Nam", "Thái Hà Books", "Đông A", "Huy Hoàng", "Đinh Tị", "1980 Books", "Bloom Books"},
        /* 50 Đồ chơi trẻ em */  {"LEGO", "Hot Wheels", "Barbie", "Nerf", "Play-Doh", "Fisher-Price", "Hasbro", "Bandai", "Funko", "Playmobil", "Polesie", "Đồ chơi Kiểu Nhật"}
    };

    private static final String[][] MODELS = {
        /* 1  Điện thoại */       {"15 Pro Max", "15 Pro", "15 Plus", "15", "14 Pro Max", "14", "S24 Ultra", "S24+", "S24", "S23 FE", "Z Fold 5", "Z Flip 5", "A55", "A35 5G", "A25", "A15", "14T Pro", "14 Pro", "Redmi Note 13 Pro+", "Redmi Note 13", "Redmi 13C", "14 Ultra", "Find X7 Ultra", "Reno 11 Pro", "Reno 11", "A79 5G", "V30 Pro", "V30 5G", "Y36", "GT5 Pro", "12R", "12", "Pixel 8 Pro", "Pixel 8a", "Mate 60 Pro", "Edge 50 Pro", "Magic 6 Pro", "Phone (2)", "G85"},
        /* 2  Laptop */           {"XPS 15", "XPS 13", "Inspiron 16", "Inspiron 15", "Latitude 14", "Pavilion 15", "Envy 16", "EliteBook 840", "ProBook 450", "ThinkPad X1 Carbon", "ThinkPad T14s", "IdeaPad 5", "Legion 5 Pro", "Yoga 9i", "ZenBook 14", "Vivobook S15", "ROG Strix G16", "TUF Gaming F15", "Nitro V 15", "Aspire 5", "Predator Helios 18", "Creator Z16", "Raider GE78", "Air M3", "Pro M3 Max", "Air M2", "Gram 17", "MateBook X Pro", "Laptop Go 3", "Surface Pro 9", "Aero 16"},
        /* 3  Tablet */           {"Pro 12.9 M2", "Air M2", "Mini 6", "Gen 10", "S9 Ultra", "S9 FE+", "S9 FE", "A9+", "6 Pro", "6", "P12 Pro", "M11", "Pro 12.7", "T3 10 Plus", "MatePad 11.5", "MatePad SE", "Air 2", "Tab 8 WiFi", "Tab 10L", "HD 10"},
        /* 4  Smartwatch */       {"Series 9", "SE 2", "Ultra 2", "6 Classic", "6", "FE", "Forerunner 265", "Venu 3", "Fenix 7X", "S3", "Color 2", "GT 4 Pro", "GT 4", "GTR 4", "GTS 4 Mini", "T-Rex Ultra", "Sense 2", "Versa 4", "Free", "Gen 6"},
        /* 5  Tai nghe */         {"WH-1000XM5", "WF-1000XM5", "WH-CH720N", "Pro 2", "Max", "Gen 3", "Buds 3 Pro", "Buds FE", "Live 2", "Tour Pro 2", "Tune 770NC", "QuietComfort Ultra", "NC 700", "HD 660S2", "MTW 4", "Momentum 4", "ATH-M50x", "Elite 10", "Elite 85t", "Solo 4", "Studio Pro", "Space A40", "Life Q35", "Major V", "Monitor II", "Crusher Evo", "Buds 4 Pro", "Cloud Alpha", "Arctis Nova Pro"},
        /* 6  Phụ kiện ĐT */     {"Ốp lưng", "Kính cường lực", "Cáp sạc USB-C", "Cáp Lightning", "Củ sạc nhanh 65W", "Củ sạc 20W", "Đế sạc không dây", "Giá đỡ điện thoại", "Gậy selfie", "Túi chống nước", "Bao da", "Miếng dán màn hình", "Ring holder", "Đầu chuyển đổi", "Adapter OTG", "Tai nghe có dây"},
        /* 7  Phụ kiện Laptop */  {"Hub USB-C 7in1", "Hub USB-C 5in1", "Đế tản nhiệt", "Bao laptop 14 inch", "Bao laptop 15.6 inch", "Chuột không dây", "Bàn phím Bluetooth", "Webcam 1080p", "Webcam 4K", "Dock sạc đa năng", "Cáp HDMI 2.1", "Cáp USB-C to USB-C", "Adapter USB-C to HDMI", "Miếng dán bàn phím", "Túi laptop chống sốc"},
        /* 8  Loa */              {"Flip 6", "Charge 5", "Xtreme 4", "Go 4", "Clip 5", "SRS-XB100", "SRS-XG300", "Portable", "SoundLink Flex", "Revolve+ II", "Aura Studio 3", "Stanmore III", "Acton III", "Woburn III", "Boom 3", "Megaboom 3", "Motion 300", "Mini Speaker", "Mi Speaker", "XBOOM Go PL5"},
        /* 9  Sạc dự phòng */     {"PowerCore 20000mAh", "PowerCore 10000mAh", "PowerCore Slim", "Magnetic 5000mAh", "Adaman 20000mAh", "Blade 10000mAh", "20000mAh 22.5W", "10000mAh 33W", "Wireless 10000mAh", "Battery Pack 20W", "Slim 5000mAh", "25W Battery Pack", "MagSafe Battery", "Boost Charge 10K", "PD Pioneer 20000", "Portable Charger 30W"},
        /* 10 Camera */           {"EOS R6 Mark II", "EOS R8", "EOS R50", "EOS 90D", "PowerShot V10", "Alpha A7 IV", "Alpha A7C II", "ZV-E10 II", "ZV-1 II", "FX30", "Z8", "Z6 III", "Z50 II", "Zf", "X-T5", "X-S20", "X100VI", "Instax Mini 12", "GH6", "OM-5", "Hero 12 Black", "Mini 4 Pro", "Air 3", "Mavic 3 Pro", "Osmo Action 4", "ONE RS", "X3"},
        /* 11 Tivi */             {"OLED 4K 55 inch", "OLED 4K 65 inch", "Neo QLED 4K 55 inch", "Neo QLED 4K 75 inch", "QLED 4K 50 inch", "Crystal UHD 4K 43 inch", "Crystal UHD 4K 55 inch", "LED 4K 50 inch", "LED 4K 55 inch", "Google TV 55 inch", "Smart TV 43 inch", "Smart TV 50 inch", "Smart TV 32 inch", "Android TV 55 inch", "Mini LED 4K 65 inch", "8K 75 inch"},
        /* 12 Máy tính bàn */     {"OptiPlex 7010", "Precision 3660", "Vostro 3710", "ProDesk 400 G9", "EliteDesk 800 G9", "ThinkCentre M70q", "ThinkCentre Neo 50s", "IdeaCentre 5", "ExpertCenter D5", "Aspire XC", "ProDesk Mini", "M3 All-in-One", "M1 All-in-One", "NUC 13 Pro", "UM790 Pro", "N100 Mini PC"},
        /* 13 Bàn phím */         {"G Pro X", "G915 TKL", "MX Keys S", "K380", "BlackWidow V4", "Huntsman V3 Pro", "K100 RGB", "K65 Plus", "Apex Pro TKL", "Cloud III", "Q1 Pro", "Q3 Max", "V3", "K8 Pro", "3098B", "FC750R", "One 3 SF", "RK84", "FL980", "A87", "EK87"},
        /* 14 Chuột */            {"G Pro X Superlight 2", "G502 X Plus", "MX Master 3S", "G305", "DeathAdder V3 Pro", "Viper V3 HyperSpeed", "Orochi V2", "M750S", "Dark Core RGB Pro", "Prime Wireless", "Aerox 5", "X2 Mini", "Atlantis Mini", "EC3-C", "OP1we", "Model O 2", "A950", "EM901X"},
        /* 15 Màn hình */         {"UltraSharp U2723QE 27 4K", "S2722QC 27 QHD", "UltraGear 27GP850-B 27", "27GN800-B 27 QHD", "Odyssey G5 27 QHD", "ViewFinity S8 27 4K", "ProArt PA278QV 27", "ROG Swift PG279QM 27", "TUF Gaming VG27AQ1A 27", "Nitro XV272U 27", "MOBIUZ EX2710Q 27", "VX2718-2KPC 27", "MAG274QRF-QD 27", "Q27G3XMN 27 QHD", "27M2V 27 4K", "34WN80C-B 34 UW", "Odyssey G9 49"},
        /* 16 Card đồ họa */      {"RTX 4090", "RTX 4080 Super", "RTX 4070 Ti Super", "RTX 4070 Super", "RTX 4070", "RTX 4060 Ti", "RTX 4060", "RX 7900 XTX", "RX 7900 XT", "RX 7800 XT", "RX 7700 XT", "RX 7600", "RTX 4090 OC", "RTX 4080 Gaming X Trio", "RTX 4070 Eagle OC", "RTX 4060 Windforce", "RX 7900 XTX Nitro+"},
        /* 17 Ổ cứng & SSD */     {"990 Pro 1TB", "990 Pro 2TB", "980 Pro 1TB", "870 EVO 1TB", "870 EVO 500GB", "T7 Shield 1TB", "WD Black SN850X 1TB", "WD Blue SN580 1TB", "Blue 2TB HDD", "Barracuda 2TB", "IronWolf 4TB", "A2000 1TB", "P3 Plus 1TB", "MX500 1TB", "Ultra 3D 1TB", "Extreme Pro 2TB SSD", "XPG S70 1TB"},
        /* 18 RAM */              {"Fury Beast 16GB DDR5", "Fury Beast 32GB DDR5", "Fury DDR4 16GB 3200", "Vengeance 32GB DDR5", "Vengeance DDR4 16GB", "Trident Z5 32GB DDR5", "Ripjaws V 16GB DDR4", "Ballistix 16GB DDR4", "T-Force Delta 16GB DDR5", "XPG Lancer 16GB DDR5", "Viper Steel 16GB DDR4", "Replays 16GB DDR4"},
        /* 19 Thiết bị mạng */    {"Archer AX73", "Archer AX55", "Deco X50 Mesh 3-pack", "Deco M5 Mesh 2-pack", "RT-AX86U Pro", "RT-AX58U", "ZenWiFi XT9 Mesh", "Orbi RBK752", "Nighthawk RAX50", "DIR-X1560", "AX3000 Mesh", "N300 Mesh WiFi", "UniFi Dream Router", "hAP ax3"},
        /* 20 Máy in */           {"LaserJet Pro M404dn", "LaserJet MFP M236dw", "Smart Tank 580", "DeskJet 2810", "PIXMA G3020", "imageCLASS MF264dw", "PIXMA TS3520", "EcoTank L3250", "EcoTank L1250", "WorkForce WF-2960", "HL-L2400DW", "MFC-L2805DW", "DCP-B7640DW"},
        /* 21 Máy chơi game */    {"PS5 Standard", "PS5 Digital", "PS5 Slim", "DualSense", "Series X", "Series S", "Xbox Controller", "Switch OLED", "Switch Lite", "Switch Pro Controller", "OLED 512GB", "LCD 256GB", "ROG Ally Z1 Extreme", "Legion Go 8.8 inch", "Claw A1M"},
        /* 22 Phụ kiện gaming */  {"Kraken V3 Pro", "BlackShark V2 Pro", "Cloud III Wireless", "Void RGB Elite", "Arctis Nova 7", "ROG Delta S", "Kiyo Pro Ultra", "Facecam", "Stream Deck MK2", "Wave:3 Mic", "Kraken Kitty V2", "H150i Elite LCD", "H7 Flow", "Floe RC Ultra 360", "Level 20 RGB", "Air 540", "Formula Series"},
        /* 23 Máy giặt */         {"Inverter 9kg", "Inverter 10kg", "Inverter 8.5kg", "AI EcoBubble 10kg", "AI DD 9kg Inverter", "UltimateCare 500 9kg", "Inverter 9.5kg", "TurboWash 360 11kg", "Cửa trên 9kg", "Cửa trước 8kg", "Lồng đứng 10kg", "Inverter 7.5kg", "AddWash 10kg"},
        /* 24 Tủ lạnh */          {"Inverter 300L", "Inverter 360L", "Inverter 400L", "Side by Side 600L", "French Door 500L", "Multi Door 580L", "Inverter 250L", "Inverter 200L", "Mini 90L", "Ngăn đá trên 340L", "2 cánh 320L", "3 cánh 450L", "Bespoke 380L"},
        /* 25 Điều hòa */         {"Inverter 1HP", "Inverter 1.5HP", "Inverter 2HP", "1 chiều 1HP", "1 chiều 1.5HP", "2 chiều Inverter 1.5HP", "2 chiều Inverter 2HP", "WiFi Inverter 1HP", "Inverter 9000BTU", "Inverter 12000BTU", "Inverter 18000BTU", "Inverter 24000BTU"},
        /* 26 Máy lọc nước */     {"RO 10 lõi", "RO 9 lõi nóng lạnh", "RO 8 lõi", "Hydrogen 10 lõi", "Nano 6 lõi", "RO để bàn", "Tích hợp nóng lạnh", "RO 100GPD", "RO 75GPD", "Undersink RO", "Countertop"},
        /* 27 Máy lọc KK */      {"Pro H", "Air Purifier 4 Pro", "Air Purifier 4 Lite", "AX60R5080WD", "F-PXV50", "KC-G60V", "AP-1019C", "MC55UVM6", "Purifier Big", "Core 400S", "Core 300S", "Classic 480i", "5500-2", "C530A"},
        /* 28 Robot hút bụi */    {"S8 Pro Ultra", "S7 Max Ultra", "Q Revo", "Q7 Max+", "Deebot X2 Omni", "Deebot T20 Omni", "Roomba j7+", "Roomba i5+", "Mi Robot Vacuum X10+", "L20 Ultra", "L10s Ultra", "Jet Bot+", "360 Vis Nav", "RoboVac X8 Pro"},
        /* 29 Nồi cơm điện */     {"1.8L Inverter", "1L mini", "1.8L cao tần IH", "1.8L điện tử", "1.8L nắp gài", "1.5L tách đường", "1L IH", "1.8L lòng dày", "1L siêu tốc", "2L gia đình", "1.8L Smart", "1.5L Fuzzy Logic"},
        /* 30 Bếp từ */           {"Đôi từ 2 vùng nấu", "Đôi từ hồng ngoại", "Đơn 2000W", "Đơn 2200W", "Ba vùng nấu", "Âm 2 từ", "Âm hồng ngoại đôi", "Đơn siêu mỏng", "Bếp điện 2 mặt", "Bếp hồng ngoại đơn", "Combo bếp từ + hút mùi"},
        /* 31 Lò vi sóng */       {"Inverter 25L", "Có nướng 23L", "Điện tử 20L", "Inverter 32L", "Có nướng 28L", "Solo 20L", "Solo 23L", "Có nướng đối lưu 25L", "Smart Inverter 30L", "Cơ 20L"},
        /* 32 Nồi chiên KD */     {"5.5L Digital", "4.5L cơ bản", "7L gia đình", "3.5L mini", "6L đa năng", "8L XXL", "5L Smart WiFi", "4L Compact", "6.5L Rapid Air", "10L lồng quay", "5L Dual Basket", "12L Air Oven"},
        /* 33 Quần áo nam */      {"Áo thun cổ tròn", "Áo polo", "Áo sơ mi dài tay", "Áo sơ mi ngắn tay", "Áo khoác gió", "Áo khoác jean", "Áo hoodie", "Quần jeans slim fit", "Quần kaki", "Quần short", "Quần jogger", "Áo vest công sở", "Áo len cổ lọ", "Áo thun oversize", "Set bộ thể thao", "Quần tây công sở"},
        /* 34 Quần áo nữ */       {"Áo thun croptop", "Áo blouse", "Áo sơ mi nữ", "Đầm suông", "Đầm xòe", "Đầm maxi", "Váy midi", "Chân váy chữ A", "Quần jeans skinny", "Quần ống rộng", "Áo khoác blazer", "Áo hoodie nữ", "Set bộ công sở", "Áo len oversize", "Quần short nữ", "Đầm công sở"},
        /* 35 Giày dép nam */     {"Air Force 1", "Air Max 90", "Air Jordan 1", "Dunk Low", "Ultraboost 23", "Stan Smith", "NMD R1", "Suede Classic", "574 Classic", "Chuck Taylor All Star", "Old Skool", "1461 Oxford", "Arizona", "Hunter X", "Gel-Kayano 30", "Club C 85", "Disruptor 2"},
        /* 36 Giày dép nữ */      {"Air Force 1 Low", "Air Max 97", "Dunk Low Wmns", "Samba OG", "Gazelle Bold", "RS-X", "327", "Chuck 70", "Platform Old Skool", "Lug Sole Chelsea", "Sandal quai ngang", "Giày cao gót 7cm", "Giày búp bê", "Slip-on", "D'Lites", "Platform Sneaker"},
        /* 37 Túi xách & Balo */  {"Balo laptop 15.6 inch", "Balo du lịch 40L", "Balo thời trang", "Túi đeo chéo", "Túi tote", "Túi xách tay nữ", "Vali kéo 24 inch", "Vali cabin 20 inch", "Balo chống trộm", "Túi thể thao", "Balo Everyday 20L", "Túi máy ảnh", "Túi đựng laptop 14 inch"},
        /* 38 Đồng hồ TT */      {"G-Shock GA-2100", "G-Shock DW-5600", "Edifice EFV-540D", "Eco-Drive AW1620", "Promaster Diver", "Presage SRPD37", "5 Sports SRPD55", "Bambino V2", "Kamasu RA-AA0004E", "PRX Powermatic 80", "Classic DW00100", "Neutra Chrono", "Runway MK3178"},
        /* 39 Trang sức */        {"Nhẫn vàng 18K", "Nhẫn bạc 925", "Dây chuyền vàng 24K", "Dây chuyền bạc", "Bông tai vàng", "Bông tai ngọc trai", "Lắc tay vàng trắng", "Vòng tay charm", "Nhẫn kim cương", "Mặt dây chuyền", "Bộ trang sức cưới", "Nhẫn đôi", "Vòng ngọc bích"},
        /* 40 Kính mắt */         {"Aviator Classic", "Wayfarer", "Round Metal", "Clubmaster", "Holbrook", "Radar EV", "GG0061S", "PR 17WS", "DiorBlackSuit", "FT0237", "Her 01", "Gentle Monster Volt", "B6075", "Kính cận thời trang", "Kính râm phân cực"},
        /* 41 Nước hoa */         {"N°5 EDP", "Bleu de Chanel", "Coco Mademoiselle", "Sauvage EDP", "J'adore", "Miss Dior", "Eros EDT", "Dylan Blue", "Guilty Pour Femme", "Bloom", "Mon Paris", "Libre", "Y EDP", "Lost Cherry", "Oud Wood", "English Pear", "Peony & Blush Suede", "Eternity", "L'Eau D'Issey", "Explorer"},
        /* 42 Mỹ phẩm */         {"Kem chống nắng SPF50+", "Serum Vitamin C", "Kem dưỡng ẩm", "Sữa rửa mặt", "Toner cân bằng", "Mặt nạ giấy", "Kem nền BB Cream", "Son môi", "Son tint", "Mascara", "Phấn phủ", "Cushion", "Kem mắt", "Tẩy trang", "Serum Retinol", "BHA/AHA Toner", "Kem trị mụn"},
        /* 43 CSCC */             {"Bàn chải điện", "Máy cạo râu", "Tăm nước", "Máy sấy tóc", "Máy uốn tóc", "Máy ép tóc", "Sữa tắm 1L", "Dầu gội 650ml", "Dầu xả 650ml", "Kem đánh răng", "Nước súc miệng", "Bộ chăm sóc tóc", "Lăn khử mùi", "Kem body lotion"},
        /* 44 TPCN */             {"Vitamin C 1000mg", "Vitamin D3", "Omega 3 Fish Oil", "Collagen peptide", "Men vi sinh Probiotics", "Glucosamine 1500mg", "Canxi nano", "Vitamin tổng hợp", "Kẽm zinc", "B Complex", "Biotin 10000mcg", "Sắt + Acid Folic", "Lutein bổ mắt", "Melatonin 5mg"},
        /* 45 Đồ thể thao */     {"Giày chạy bộ", "Quần short thể thao", "Áo tank top gym", "Vợt cầu lông", "Bóng rổ size 7", "Bóng đá size 5", "Thảm tập yoga", "Dây kháng lực", "Tạ tay 5kg", "Găng tay gym", "Bình nước thể thao", "Kính bơi", "Mũ bơi silicone", "Ba lô leo núi"},
        /* 46 Xe đạp */           {"Đua Road Carbon", "Đua Road Nhôm", "MTB 29 inch", "MTB 27.5 inch", "Touring", "Gravel", "Xe đạp gấp 20 inch", "Xe đạp thành phố", "Xe đạp trẻ em 16 inch", "Xe đạp trẻ em 20 inch", "Xe đạp điện trợ lực", "Fixed Gear"},
        /* 47 Đồ dùng GĐ */      {"Bộ hộp bảo quản 10 món", "Bình giữ nhiệt 500ml", "Bộ nồi inox 3 cái", "Chảo chống dính 26cm", "Bộ dao 5 món", "Bộ chén đĩa 12 món", "Thớt gỗ", "Giá phơi đồ", "Hộp đựng gia vị", "Thùng rác thông minh", "Bộ ly thuỷ tinh 6 cái", "Ấm siêu tốc 1.7L", "Máy xay sinh tố"},
        /* 48 Nội thất */         {"Bàn làm việc 120cm", "Ghế công thái học", "Kệ sách 5 tầng", "Giường ngủ 1m6", "Giường ngủ 1m8", "Tủ quần áo 4 cánh", "Sofa góc L", "Sofa 2 chỗ", "Bàn ăn 6 ghế", "Tủ giày 3 tầng", "Kệ tivi 1m4", "Bàn trà", "Tủ đầu giường", "Ghế gaming"},
        /* 49 Sách */             {"Đắc Nhân Tâm", "Nhà Giả Kim", "Sapiens", "Atomic Habits", "Tư Duy Nhanh Và Chậm", "7 Thói Quen Hiệu Quả", "Dạy Con Làm Giàu", "Tuổi Trẻ Đáng Giá Bao Nhiêu", "Cà Phê Cùng Tony", "Muôn Kiếp Nhân Sinh", "Doraemon", "One Piece", "Conan", "Naruto", "Lập Trình Python", "Java Core", "Clean Code", "Design Patterns", "Tôi Tài Giỏi Bạn Cũng Thế", "Đời Ngắn Đừng Ngủ Dài"},
        /* 50 Đồ chơi trẻ em */  {"Classic Creative Box", "Technic Supercar", "City Police Station", "Creator 3in1", "Track Builder Set", "Monster Trucks 5-pack", "Dreamhouse", "Fashionista", "Elite 2.0 Blaster", "Mega Dart", "Kitchen Set", "Ice Cream Playset", "Magnetic Tiles 100pc", "Wooden Blocks", "RC Car 1:16", "Pop It Fidget", "Board Game Family", "Puzzle 1000pc"}
    };

    private static final String[][] VARIANTS = {
        /* 1  Điện thoại */       {"64GB", "128GB", "256GB", "512GB", "1TB", "Đen", "Trắng", "Xanh dương", "Xanh lá", "Tím", "Vàng", "Hồng", "Bạc", "Đỏ", "Titan tự nhiên", "Xám", "Kem", "5G", "4G", "Chính hãng VN/A"},
        /* 2  Laptop */           {"i5-13500H/16GB/512GB", "i7-13700H/16GB/512GB", "i7-13700H/32GB/1TB", "i9-13900H/32GB/1TB", "R5-7535HS/16GB/512GB", "R7-7840HS/16GB/512GB", "R7-7840HS/32GB/1TB", "M3/8GB/256GB", "M3 Pro/18GB/512GB", "M3 Max/36GB/1TB", "RTX 4060/16GB", "RTX 4070/32GB", "Xám", "Bạc", "Đen", "Xanh"},
        /* 3  Tablet */           {"64GB WiFi", "128GB WiFi", "256GB WiFi", "128GB 5G", "256GB 5G", "512GB WiFi", "Xám", "Bạc", "Xanh", "Hồng", "Tím", "Kem"},
        /* 4  Smartwatch */       {"41mm", "45mm", "49mm", "40mm", "44mm", "42mm", "GPS", "GPS + Cellular", "Đen", "Trắng", "Xanh", "Hồng", "Bạc", "Vàng", "Titanium"},
        /* 5  Tai nghe */         {"Đen", "Trắng", "Xanh", "Hồng", "Bạc", "Xám", "Wireless", "True Wireless", "Over-ear", "In-ear", "Noise Cancelling"},
        /* 6  Phụ kiện ĐT */     {"iPhone 15", "iPhone 15 Pro", "iPhone 15 Pro Max", "iPhone 14", "Samsung S24", "Samsung S24 Ultra", "Xiaomi 14", "Universal", "Đen", "Trắng", "Trong suốt", "Carbon"},
        /* 7  Phụ kiện Laptop */  {"Xám", "Bạc", "Đen", "USB-C", "USB-A", "Thunderbolt 4", "13-14 inch", "15-16 inch", "17 inch"},
        /* 8  Loa */              {"Đen", "Xanh", "Đỏ", "Trắng", "Hồng", "Xám", "Xanh rêu", "Bluetooth 5.3", "WiFi", "Portable", "Party"},
        /* 9  Sạc dự phòng */     {"Đen", "Trắng", "Xanh", "Hồng", "PD 20W", "PD 45W", "PD 65W", "QC 3.0", "MagSafe", "Sạc nhanh 22.5W"},
        /* 10 Camera */           {"Body Only", "Kit 18-55mm", "Kit 24-70mm", "Kit 28-60mm", "Kit 15-45mm", "Lens 35mm f1.8", "Lens 50mm f1.4", "Đen", "Bạc", "4K 60fps", "8K"},
        /* 11 Tivi */             {"2024", "2023", "2022", "Smart Tizen", "Smart webOS", "Google TV", "Android TV", "Tràn viền", "Chân đế", "Treo tường"},
        /* 12 Máy tính bàn */     {"i5/16GB/512GB SSD", "i7/16GB/512GB SSD", "i7/32GB/1TB SSD", "R5/16GB/512GB SSD", "R7/32GB/1TB SSD", "Đen", "Trắng", "Mini", "Tower", "All-in-One"},
        /* 13 Bàn phím */         {"Red Switch", "Brown Switch", "Blue Switch", "Silent Red", "Speed Silver", "Đen", "Trắng", "RGB", "TKL", "Full-size", "65%", "75%", "Wireless", "Hot-swap"},
        /* 14 Chuột */            {"Đen", "Trắng", "Hồng", "Wireless", "Wired", "4K DPI", "25600 DPI", "Lightweight 49g", "Lightweight 55g", "Ergonomic", "Ambidextrous"},
        /* 15 Màn hình */         {"IPS", "VA", "OLED", "144Hz", "165Hz", "240Hz", "360Hz", "HDR10", "HDR600", "USB-C", "FreeSync", "G-Sync", "Pivot", "Curved"},
        /* 16 Card đồ họa */      {"24GB GDDR6X", "16GB GDDR6X", "12GB GDDR6X", "8GB GDDR6", "16GB GDDR6", "OC Edition", "Gaming", "Eagle", "Ventus", "WINDFORCE"},
        /* 17 Ổ cứng & SSD */     {"NVMe PCIe 4.0", "NVMe PCIe 5.0", "SATA III", "USB 3.2", "USB-C", "500GB", "1TB", "2TB", "4TB", "8TB"},
        /* 18 RAM */              {"4800MHz", "5200MHz", "5600MHz", "6000MHz", "6400MHz", "3200MHz", "3600MHz", "CL16", "CL18", "CL30", "CL36", "RGB"},
        /* 19 Thiết bị mạng */    {"WiFi 6", "WiFi 6E", "WiFi 7", "AX3000", "AX5400", "AX6000", "Mesh 2-pack", "Mesh 3-pack", "Gigabit", "2.5G"},
        /* 20 Máy in */           {"Đen trắng", "Màu", "In 2 mặt", "In scan copy", "In scan copy fax", "WiFi", "Ethernet", "Laser", "Phun màu", "Tank"},
        /* 21 Máy chơi game */    {"Trắng", "Đen", "Limited Edition", "Bundle Game", "1TB", "512GB", "Joy-Con Neon", "Joy-Con Xám"},
        /* 22 Phụ kiện gaming */  {"Đen", "Trắng", "RGB", "Wireless", "7.1 Surround", "Mechanical", "1080p", "4K", "Streaming", "Racing"},
        /* 23 Máy giặt */        {"Cửa trước", "Cửa trên", "Lồng đứng", "Giặt sấy", "Trắng", "Bạc", "Đen", "Steam Wash", "AI Control"},
        /* 24 Tủ lạnh */         {"Bạc", "Đen", "Trắng", "No Frost", "Ngăn đá trên", "Ngăn đá dưới", "Inverter", "Smart WiFi"},
        /* 25 Điều hòa */        {"Trắng", "Gas R32", "Gas R410A", "WiFi Control", "Lọc bụi PM2.5", "Tiết kiệm điện", "Thanh lọc ion"},
        /* 26 Máy lọc nước */    {"Trắng", "Đen", "Bạc", "Nóng lạnh nguội", "Nóng nguội", "Để bàn", "Đứng", "Âm tủ bếp"},
        /* 27 Máy lọc KK */      {"Trắng", "Đen", "20m²", "30m²", "40m²", "60m²", "HEPA H13", "Ion âm", "UV-C"},
        /* 28 Robot hút bụi */   {"Đen", "Trắng", "Hút lau", "Tự giặt giẻ", "Tự đổ rác", "LiDAR", "Camera AI", "Đa tầng"},
        /* 29 Nồi cơm điện */    {"Trắng", "Đen", "Bạc", "Hồng", "Lòng dày 2mm", "Lòng gốm", "Lòng men ceramic"},
        /* 30 Bếp từ */          {"Đen", "Mặt kính Schott", "Mặt kính EuroKera", "Đơn", "Đôi", "Âm tủ", "Dương"},
        /* 31 Lò vi sóng */      {"Trắng", "Đen", "Bạc", "Có nướng", "Có đối lưu", "Inverter", "Cơ bản"},
        /* 32 Nồi chiên KD */    {"Đen", "Trắng", "Bạc", "Xanh", "Hồng", "Digital", "Cơ bản", "2 ngăn", "Lồng quay"},
        /* 33 Quần áo nam */     {"S", "M", "L", "XL", "XXL", "Đen", "Trắng", "Xanh navy", "Xám", "Be", "Kẻ sọc", "Cotton", "Polyester", "Linen"},
        /* 34 Quần áo nữ */      {"S", "M", "L", "XL", "Freesize", "Đen", "Trắng", "Hồng", "Đỏ", "Xanh", "Hoa", "Cotton", "Lụa", "Voan"},
        /* 35 Giày dép nam */    {"39", "40", "41", "42", "43", "44", "Đen", "Trắng", "Xanh", "Đỏ", "Xám", "Nâu"},
        /* 36 Giày dép nữ */     {"35", "36", "37", "38", "39", "40", "Đen", "Trắng", "Hồng", "Be", "Nâu", "Đỏ"},
        /* 37 Túi xách & Balo */ {"Đen", "Xám", "Navy", "Xanh rêu", "Hồng", "Nâu", "Polyester", "Nylon", "Canvas", "Da PU"},
        /* 38 Đồng hồ TT */     {"Nam", "Nữ", "Unisex", "Dây thép", "Dây da", "Dây cao su", "Dây NATO", "Mặt 40mm", "Mặt 42mm", "Mặt 44mm"},
        /* 39 Trang sức */       {"Vàng 18K", "Vàng 24K", "Bạc 925", "Bạch kim", "Hồng", "Vàng hồng", "Size 6", "Size 7", "Size 8", "Size 9"},
        /* 40 Kính mắt */        {"Đen", "Nâu", "Bạc", "Vàng", "Xanh", "Gọng kim loại", "Gọng nhựa", "Gọng titan", "UV400", "Polarized"},
        /* 41 Nước hoa */        {"30ml", "50ml", "100ml", "EDP", "EDT", "Parfum", "Nam", "Nữ", "Unisex", "Travel size 10ml"},
        /* 42 Mỹ phẩm */        {"30ml", "50ml", "100ml", "150ml", "200ml", "Tone sáng", "Tone tối", "Da dầu", "Da khô", "Da hỗn hợp", "Da nhạy cảm"},
        /* 43 CSCC */            {"Đen", "Trắng", "Hồng", "Xanh", "Nam", "Nữ", "250ml", "500ml", "650ml", "1L"},
        /* 44 TPCN */            {"30 viên", "60 viên", "90 viên", "120 viên", "180 viên", "Hộp", "Chai", "Túi", "Dạng bột", "Dạng nước"},
        /* 45 Đồ thể thao */    {"S", "M", "L", "XL", "Đen", "Trắng", "Xanh", "Đỏ", "Hồng", "Nam", "Nữ", "Unisex"},
        /* 46 Xe đạp */          {"Đen", "Trắng", "Đỏ", "Xanh", "Size S", "Size M", "Size L", "Khung nhôm", "Khung carbon", "Khung thép"},
        /* 47 Đồ dùng GĐ */     {"Inox 304", "Nhựa PP", "Thuỷ tinh", "Gỗ tự nhiên", "Nhôm", "Đen", "Trắng", "Hồng", "Xanh", "Bộ lớn", "Bộ nhỏ"},
        /* 48 Nội thất */        {"Gỗ tự nhiên", "Gỗ MDF", "Gỗ công nghiệp", "Kim loại", "Đen", "Trắng", "Nâu", "Xám", "Gỗ sáng", "Gỗ tối"},
        /* 49 Sách */            {"Bìa mềm", "Bìa cứng", "Combo 3 cuốn", "Combo 5 cuốn", "Limited Edition", "Tái bản 2024", "Tái bản 2025", "Song ngữ"},
        /* 50 Đồ chơi trẻ em */ {"0-3 tuổi", "3-6 tuổi", "6-12 tuổi", "12+ tuổi", "Nam", "Nữ", "Unisex", "Đỏ", "Xanh", "Hồng", "Nhiều màu"}
    };

    // Price ranges (VND): {min, max}
    private static final int[][] PRICE_RANGES = {
        {3_000_000, 50_000_000},    // 1  Điện thoại
        {8_000_000, 80_000_000},    // 2  Laptop
        {3_000_000, 40_000_000},    // 3  Tablet
        {1_000_000, 25_000_000},    // 4  Smartwatch
        {200_000, 12_000_000},      // 5  Tai nghe
        {50_000, 2_000_000},        // 6  Phụ kiện ĐT
        {100_000, 5_000_000},       // 7  Phụ kiện Laptop
        {300_000, 15_000_000},      // 8  Loa
        {200_000, 3_000_000},       // 9  Sạc dự phòng
        {2_000_000, 100_000_000},   // 10 Camera
        {3_000_000, 80_000_000},    // 11 Tivi
        {5_000_000, 60_000_000},    // 12 Máy tính bàn
        {200_000, 8_000_000},       // 13 Bàn phím
        {100_000, 4_000_000},       // 14 Chuột
        {2_000_000, 30_000_000},    // 15 Màn hình
        {3_000_000, 60_000_000},    // 16 Card đồ họa
        {300_000, 10_000_000},      // 17 Ổ cứng & SSD
        {300_000, 8_000_000},       // 18 RAM
        {200_000, 15_000_000},      // 19 Thiết bị mạng
        {1_000_000, 20_000_000},    // 20 Máy in
        {3_000_000, 20_000_000},    // 21 Máy chơi game
        {200_000, 10_000_000},      // 22 Phụ kiện gaming
        {4_000_000, 25_000_000},    // 23 Máy giặt
        {3_000_000, 40_000_000},    // 24 Tủ lạnh
        {5_000_000, 30_000_000},    // 25 Điều hòa
        {2_000_000, 15_000_000},    // 26 Máy lọc nước
        {2_000_000, 20_000_000},    // 27 Máy lọc KK
        {3_000_000, 30_000_000},    // 28 Robot hút bụi
        {500_000, 8_000_000},       // 29 Nồi cơm điện
        {500_000, 15_000_000},      // 30 Bếp từ
        {800_000, 8_000_000},       // 31 Lò vi sóng
        {500_000, 5_000_000},       // 32 Nồi chiên KD
        {100_000, 3_000_000},       // 33 Quần áo nam
        {100_000, 3_000_000},       // 34 Quần áo nữ
        {300_000, 6_000_000},       // 35 Giày dép nam
        {200_000, 5_000_000},       // 36 Giày dép nữ
        {200_000, 8_000_000},       // 37 Túi xách & Balo
        {500_000, 30_000_000},      // 38 Đồng hồ TT
        {200_000, 50_000_000},      // 39 Trang sức
        {300_000, 10_000_000},      // 40 Kính mắt
        {300_000, 10_000_000},      // 41 Nước hoa
        {50_000, 5_000_000},        // 42 Mỹ phẩm
        {50_000, 3_000_000},        // 43 CSCC
        {100_000, 2_000_000},       // 44 TPCN
        {50_000, 5_000_000},        // 45 Đồ thể thao
        {2_000_000, 50_000_000},    // 46 Xe đạp
        {30_000, 3_000_000},        // 47 Đồ dùng GĐ
        {500_000, 20_000_000},      // 48 Nội thất
        {30_000, 500_000},          // 49 Sách
        {50_000, 3_000_000}         // 50 Đồ chơi trẻ em
    };

    // ===================== MAIN ENTRY POINT =====================
    @Override
    public void run(String... args) throws Exception {
        try (Connection conn = dataSource.getConnection()) {
            conn.setAutoCommit(false);
            log.info("=== DATABASE SEEDER STARTED ===");
            long start = System.currentTimeMillis();

            cleanDatabase(conn);
            seedCategories(conn);
            seedProducts(conn);
            seedProductImages(conn);

            conn.commit();
            long elapsed = (System.currentTimeMillis() - start) / 1000;
            log.info("=== SEEDING COMPLETED IN {} seconds ===", elapsed);
        }
    }

    // ===================== CLEAN DATABASE =====================
    private void cleanDatabase(Connection conn) throws SQLException {
        log.info("Cleaning database...");
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("SET FOREIGN_KEY_CHECKS = 0");
            stmt.execute("TRUNCATE TABLE product_images");
            stmt.execute("TRUNCATE TABLE order_details");
            stmt.execute("TRUNCATE TABLE orders");
            stmt.execute("TRUNCATE TABLE products");
            stmt.execute("TRUNCATE TABLE categories");
            stmt.execute("SET FOREIGN_KEY_CHECKS = 1");
        }
        log.info("Database cleaned");
    }

    // ===================== SEED CATEGORIES =====================
    private void seedCategories(Connection conn) throws SQLException {
        log.info("Seeding {} categories...", CATEGORY_NAMES.length);
        String sql = "INSERT INTO categories (id, name) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < CATEGORY_NAMES.length; i++) {
                ps.setLong(1, i + 1);
                ps.setString(2, CATEGORY_NAMES[i]);
                ps.addBatch();
            }
            ps.executeBatch();
        }
        log.info("Categories seeded");
    }

    // ===================== SEED PRODUCTS =====================
    private void seedProducts(Connection conn) throws SQLException {
        log.info("Seeding {} products...", TOTAL_PRODUCTS);
        String sql = "INSERT INTO products (id, name, price, thumbnail, description, category_id, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int productId = 0;
            int batchCount = 0;

            for (int catIdx = 0; catIdx < CATEGORY_NAMES.length; catIdx++) {
                int categoryId = catIdx + 1;
                int numProducts = PRODUCTS_PER_CATEGORY[catIdx];
                String[] brands = BRANDS[catIdx];
                String[] models = MODELS[catIdx];
                String[] variants = VARIANTS[catIdx];
                int minPrice = PRICE_RANGES[catIdx][0];
                int maxPrice = PRICE_RANGES[catIdx][1];

                for (int i = 0; i < numProducts; i++) {
                    productId++;
                    String brand = brands[random.nextInt(brands.length)];
                    String model = models[random.nextInt(models.length)];
                    String variant = variants[random.nextInt(variants.length)];
                    String name = brand + " " + model + " " + variant;
                    float price = roundPrice(minPrice + random.nextFloat() * (maxPrice - minPrice));
                    String thumbnail = "product-" + productId + "-1.jpg";
                    String description = generateDescription(CATEGORY_NAMES[catIdx], name, brand);
                    LocalDateTime createdAt = randomPastDate();
                    LocalDateTime updatedAt = createdAt.plusDays(random.nextInt(30));

                    ps.setLong(1, productId);
                    ps.setString(2, name);
                    ps.setFloat(3, price);
                    ps.setString(4, thumbnail);
                    ps.setString(5, description);
                    ps.setLong(6, categoryId);
                    ps.setTimestamp(7, Timestamp.valueOf(createdAt));
                    ps.setTimestamp(8, Timestamp.valueOf(updatedAt));
                    ps.addBatch();
                    batchCount++;

                    if (batchCount % BATCH_SIZE == 0) {
                        ps.executeBatch();
                        log.info("  Products inserted: {}/{}", productId, TOTAL_PRODUCTS);
                    }
                }
            }
            // flush remaining
            if (batchCount % BATCH_SIZE != 0) {
                ps.executeBatch();
            }
        }

        // reset auto_increment
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("ALTER TABLE products AUTO_INCREMENT = " + (TOTAL_PRODUCTS + 1));
        }
        log.info("Products seeded: {}", TOTAL_PRODUCTS);
    }

    // ===================== SEED PRODUCT IMAGES =====================
    private void seedProductImages(Connection conn) throws SQLException {
        log.info("Seeding product images...");
        String sql = "INSERT INTO product_images (product_id, image_url) VALUES (?, ?)";

        int totalImages = 0;
        int batchCount = 0;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int productId = 1; productId <= TOTAL_PRODUCTS; productId++) {
                int numImages = 2 + random.nextInt(4); // 2-5 images

                for (int imgIdx = 1; imgIdx <= numImages; imgIdx++) {
                    ps.setLong(1, productId);
                    ps.setString(2, "product-" + productId + "-" + imgIdx + ".jpg");
                    ps.addBatch();
                    totalImages++;
                    batchCount++;

                    if (batchCount % BATCH_SIZE == 0) {
                        ps.executeBatch();
                        batchCount = 0;
                        if (totalImages % 50_000 == 0) {
                            log.info("  Images inserted: {}", totalImages);
                        }
                    }
                }
            }
            // flush remaining
            if (batchCount > 0) {
                ps.executeBatch();
            }
        }
        log.info("Product images seeded: {}", totalImages);
    }

    // ===================== HELPER METHODS =====================

    private String generateDescription(String category, String productName, String brand) {
        String[] templates = {
            "%s chính hãng %s. Sản phẩm thuộc danh mục %s, chất lượng cao, bảo hành chính hãng. %s",
            "%s - sản phẩm %s được yêu thích nhất trong danh mục %s. %s",
            "Mua %s giá tốt nhất tại ShopApp. Thương hiệu %s uy tín, thuộc danh mục %s. %s",
            "%s từ %s. %s chất lượng, giá cả phải chăng. %s",
            "Sản phẩm %s thương hiệu %s. Danh mục: %s. Giao hàng nhanh, đổi trả dễ dàng. %s"
        };
        String template = templates[random.nextInt(templates.length)];
        String extra = faker.lorem().sentence(8 + random.nextInt(12));
        return String.format(template, productName, brand, category, extra);
    }

    private float roundPrice(float price) {
        // Round to nearest 10,000 VND
        return Math.round(price / 10_000f) * 10_000f;
    }

    private LocalDateTime randomPastDate() {
        // Random date from 2024-01-01 to 2026-02-01
        long minDay = LocalDateTime.of(2024, 1, 1, 0, 0).toLocalDate().toEpochDay();
        long maxDay = LocalDateTime.of(2026, 2, 1, 0, 0).toLocalDate().toEpochDay();
        long randomDay = minDay + (long) (random.nextDouble() * (maxDay - minDay));
        return LocalDateTime.of(
            java.time.LocalDate.ofEpochDay(randomDay),
            java.time.LocalTime.of(random.nextInt(24), random.nextInt(60), random.nextInt(60))
        );
    }
}
