# Mantém a ponte JavaScript usada pelo jogo (botão "Sair do jogo")
-keepclassmembers class com.empreenderthz.mundoavesso.MainActivity$Bridge {
    @android.webkit.JavascriptInterface <methods>;
}
