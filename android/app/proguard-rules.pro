# Supabase va boshqa kutubxonalar uchun qoidalar
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**

# Kotlin korutinalari uchun qo'llab-quvvatlash
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**

# Javax uchun (ehtimoliy muammolarni hal qilish)
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**

# App-specific
-keep class com.example.dictionary.** { *; }
-dontwarn com.example.dictionary.**
