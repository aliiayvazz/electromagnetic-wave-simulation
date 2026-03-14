%% ELEKTROMAGNETİK ALAN TEORİSİ - BİLGİSAYAR PROJESİ
% Öğrenci: Muhammet Ali Ayvaz - 210102002078
% Tarih: 31 Aralık 2025

clear; clc;

% --- SABİTLER VE PARAMETRELER ---
eps0 = 8.854187817e-12; % Boşluğun dielektrik katsayısı
k = 1 / (4 * pi * eps0); 

% b şıkkı kısıtı: a = 3 cm = 0.03 m 
a = 0.03; 
Q = input('Toplam yük değerini (Q) Coulomb cinsinden giriniz (Örn: 1e-9): ');

% Gözlem noktası (b şıkkı için 0,0,0 isteniyor) 
x = input('Gözlem noktası x: ');
y = input('Gözlem noktası y: ');
z = input('Gözlem noktası z: ');

% --- SAYISAL İNTEGRAL HESABI (a Şıkkı Mantığı) ---
N = 10000; % Çemberi böleceğimiz parça sayısı (Hassasiyet)
d_phi = (pi/2) / N; % Her bir parçanın açısal genişliği
V_toplam = 0;

for i = 1:N
    % Her bir küçük dq yükünün konumu (phi_prime)
    phi_p = (i - 0.5) * d_phi;
    
    % Kaynak koordinatları
    xp = a * cos(phi_p);
    yp = a * sin(phi_p);
    zp = 0;
    
    % Mesafe hesabı (R)
    R = sqrt((x-xp)^2 + (y-yp)^2 + (z-zp)^2);
    
    % dq yük miktarı (Q / (pi/2) * d_phi)
    dq = (2 * Q / pi) * d_phi;
    
    % Potansiyel katkısı ekle: dV = k * dq / R
    V_toplam = V_toplam + k * (dq / R);
end

% --- SONUÇLARIN YAZDIRILMASI ---
fprintf('\n--- PROJE SONUÇLARI ---\n');
fprintf('Yarıçap (a): %.2f cm\n', a*100);
fprintf('Gözlem Noktası: P(%g, %g, %g)\n', x, y, z);
fprintf('Hesaplanan Potansiyel (V): %.4f Volt\n', V_toplam);

% Doğrulama (Analitik): V = Q / (4*pi*eps0*a)
V_analitik = k * Q / a;
fprintf('Analitik (Teorik) Değer: %.4f Volt\n', V_analitik);