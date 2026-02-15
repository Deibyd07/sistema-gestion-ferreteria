<template>
  <div
    ref="containerRef"
    class="relative min-h-screen bg-[#0A0E17] overflow-hidden"
    :class="[customCursorEnabled ? 'cursor-none' : 'cursor-auto']"
    @mousemove="onMouseMove"
  >
    <!-- Custom Cursor -->
    <div
      v-if="customCursorEnabled"
      class="fixed w-8 h-8 rounded-full border-2 border-accent-400 pointer-events-none transition-transform duration-150 ease-out z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: `translate(-50%, -50%) scale(${cursorScale})`,
      }"
    ></div>
    <div
      v-if="customCursorEnabled"
      class="fixed w-2 h-2 rounded-full bg-accent-400 pointer-events-none z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Aurora Borealis Effect -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none z-0">
      <div 
        class="absolute w-full h-full"
        style="
          background: 
            radial-gradient(ellipse 80% 50% at 50% -20%, rgba(20, 184, 166, 0.15), transparent),
            radial-gradient(ellipse 60% 50% at 80% 50%, rgba(139, 92, 246, 0.10), transparent),
            radial-gradient(ellipse 60% 50% at 20% 80%, rgba(34, 211, 238, 0.10), transparent);
          animation: aurora 15s ease-in-out infinite;
        "
      ></div>
    </div>

    <!-- Cinematic Overlays -->
    <div class="fixed inset-0 pointer-events-none z-0 cinematic-vignette"></div>
    <div class="fixed inset-0 pointer-events-none z-0 film-grain opacity-20"></div>

    <!-- Sophisticated Background -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
      <!-- Animated Mesh Gradients -->
      <div 
        class="absolute top-0 left-0 right-0 h-[600px] bg-gradient-to-b from-accent-500/5 via-cyan-500/5 to-transparent blur-3xl animate-float"
        style="animation-duration: 8s;"
        :style="{ transform: `translateY(${scrollY * 0.3}px)` }"
      ></div>
      <div 
        class="absolute bottom-0 left-0 w-[600px] h-[600px] bg-violet-500/5 rounded-full blur-3xl animate-float-slow"
        style="animation-duration: 12s; animation-delay: -2s;"
        :style="{ transform: `translateY(${scrollY * -0.2}px) translateX(${scrollY * 0.1}px)` }"
      ></div>
      <div 
        class="absolute top-1/2 right-0 w-[500px] h-[500px] bg-cyan-500/5 rounded-full blur-3xl animate-float"
        style="animation-duration: 10s; animation-delay: -4s;"
        :style="{ transform: `translateY(${scrollY * 0.15}px) translateX(${scrollY * -0.1}px)` }"
      ></div>
      
      <!-- Animated Grid -->
      <div class="absolute inset-0 animate-pulse-subtle" style="background-image: radial-gradient(circle at 1px 1px, rgba(148, 163, 184, 0.05) 1px, transparent 0); background-size: 40px 40px;"></div>
      
      <!-- Floating Particles -->
      <div
        v-for="n in 20"
        :key="n"
        class="absolute w-1 h-1 rounded-full bg-accent-400/20"
        :style="{
          left: `${Math.random() * 100}%`,
          top: `${Math.random() * 100}%`,
          animation: `float ${5 + Math.random() * 5}s ease-in-out infinite`,
          animationDelay: `${Math.random() * 5}s`
        }"
      ></div>
    </div>

    <div class="relative z-10">
      <!-- Navigation -->
      <nav 
        class="border-b backdrop-blur-xl sticky top-0 z-50 transition-all duration-500"
        :class="scrollY > 50 ? 'border-white/10 bg-[#0A0E17]/95 shadow-2xl shadow-black/20' : 'border-white/5 bg-[#0A0E17]/80'"
      >
        <!-- Scroll Progress Bar -->
        <div class="absolute bottom-0 left-0 h-0.5 bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 transition-all duration-300" :style="{ width: `${scrollProgress}%` }"></div>
        
        <div class="max-w-7xl mx-auto px-6 lg:px-8">
          <div class="flex items-center justify-between h-16">
            <div class="flex items-center gap-3 group cursor-pointer">
              <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-accent-400 to-cyan-500 flex items-center justify-center group-hover:scale-110 transition-transform duration-300 shadow-lg shadow-accent-500/20 group-hover:shadow-accent-500/40">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <span class="text-lg font-semibold text-white tracking-tight">FerreCloud</span>
            </div>
            
            <div class="flex items-center gap-8 text-sm">
              <a href="#features" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Características</a>
              <a href="#about" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Acerca de</a>
              <a href="#contact" class="text-slate-400 hover:text-white transition-all hover:translate-y-[-2px]">Contacto</a>
              <router-link to="/auth/login" class="relative px-4 py-2 rounded-lg bg-white/5 hover:bg-white/10 text-white text-sm font-medium transition-all border border-white/10 hover:border-white/20 hover:scale-105 active:scale-95 group overflow-hidden">
                <span class="relative z-10">Iniciar Sesión</span>
                <div class="absolute inset-0 bg-gradient-to-r from-accent-500/0 via-accent-500/10 to-accent-500/0 translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
              </router-link>
            </div>
          </div>
        </div>
      </nav>

      <!-- Hero Section -->
      <section class="pt-20 pb-8 px-6 relative z-20">
        <div class="max-w-7xl mx-auto">
          <div class="text-center max-w-4xl mx-auto space-y-6 relative z-20">
            <!-- Badge -->
            <div 
              class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10 text-sm text-slate-300 backdrop-blur-xl hover:scale-105 transition-transform duration-300 cursor-pointer group animate-fade-in"
            >
              <span class="relative flex h-2 w-2">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-500"></span>
              </span>
              <span class="group-hover:text-white transition-colors">Sistema de Gestión Empresarial</span>
            </div>
            
            <!-- Main Title -->
            <h1 
              class="text-6xl lg:text-7xl font-bold tracking-tight leading-tight text-white animate-fade-in"
              style="animation-delay: 0.1s;"
            >
              ¿Listo para transformar tu ferretería?
            </h1>
            
            <!-- Description -->
            <p 
              class="text-2xl text-slate-400 max-w-3xl mx-auto leading-relaxed animate-fade-in"
              style="animation-delay: 0.2s;"
            >
              Únete a más de 500 ferreterías que ya confían en FerreCloud. Sin tarjeta de crédito para empezar.
            </p>
            
            <!-- CTA Buttons -->
            <div 
              class="flex flex-col sm:flex-row items-center justify-center gap-4 pt-6 animate-fade-in"
              style="animation-delay: 0.3s;"
            >
              <router-link 
                to="/auth/login"
                class="group relative px-10 py-5 rounded-xl bg-gradient-to-r from-accent-500 to-cyan-500 text-white font-semibold text-xl shadow-2xl shadow-accent-500/20 hover:shadow-accent-500/40 transition-all duration-300 overflow-hidden hover:scale-105 active:scale-95"
              >
                <span class="relative z-10 flex items-center">
                  <svg class="w-5 h-5 mr-2 group-hover:rotate-12 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                  </svg>
                  Comenzar Gratis
                </span>
                <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent skew-x-12 translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
              </router-link>
              
              <a 
                href="#"
                class="group relative px-10 py-5 rounded-xl text-slate-300 hover:text-white font-semibold text-xl border border-white/10 hover:border-white/20 hover:bg-white/5 transition-all duration-300 hover:scale-105 active:scale-95 overflow-hidden"
              >
                <span class="relative z-10 flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                  </svg>
                  Ver Demo
                </span>
              </a>
            </div>
            
            <!-- Feature Tags -->
            <div 
              class="flex flex-wrap items-center justify-center gap-8 pt-8 text-base text-slate-400 animate-fade-in"
              style="animation-delay: 0.4s;"
            >
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-accent-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Prueba gratis 14 días</span>
              </div>
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-accent-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Sin tarjeta requerida</span>
              </div>
              <div class="flex items-center gap-2">
                <svg class="w-5 h-5 text-accent-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span>Cancela cuando quieras</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Features Section -->
      <section id="features" class="pt-24 pb-20 px-6 relative">
        <div class="max-w-7xl mx-auto">
          <div class="text-center mb-16 animate-fade-in">
            <h2 class="text-4xl lg:text-5xl font-bold mb-4">
              <span class="bg-gradient-to-r from-white via-pink-400 to-purple-500 bg-clip-text text-transparent animate-gradient-shift bg-[length:200%_auto]">
                Todo lo que necesitas
              </span>
            </h2>
            <p class="text-xl text-slate-400 max-w-2xl mx-auto">
              Potentes herramientas diseñadas para hacer crecer tu negocio
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div 
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden hover:bg-white/[0.04] hover:border-white/20 animate-fade-in"
              style="animation-delay: 0.1s; transition: background-color 0.5s ease, border-color 0.5s ease;"
              :style="featureStyles[0]"
              @mouseenter="onFeatureHover($event, 0)"
              @mousemove="onFeatureMove($event, 0)"
              @mouseleave="onFeatureLeave(0)"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-accent-500/0 via-accent-500/5 to-cyan-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-accent-500/20 to-cyan-500/20 border border-accent-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-accent-400 group-hover:text-accent-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                  </svg>
                </div>
                <h3 class="text-xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-accent-400 group-hover:to-cyan-400 group-hover:bg-clip-text transition-all">Control de Inventario</h3>
                <p class="text-slate-400 leading-relaxed group-hover:text-slate-300 transition-colors">
                  Gestiona tu stock en tiempo real. Alertas automáticas, categorías, proveedores y más.
                </p>
              </div>
              
              <!-- Shine effect -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>

            <!-- Feature 2 -->
            <div 
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden hover:bg-white/[0.04] hover:border-white/20 animate-fade-in"
              style="animation-delay: 0.2s; transition: background-color 0.5s ease, border-color 0.5s ease;"
              :style="featureStyles[1]"
              @mouseenter="onFeatureHover($event, 1)"
              @mousemove="onFeatureMove($event, 1)"
              @mouseleave="onFeatureLeave(1)"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-cyan-500/0 via-cyan-500/5 to-blue-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-cyan-500/20 to-blue-500/20 border border-cyan-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-cyan-400 group-hover:text-cyan-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                  </svg>
                </div>
                <h3 class="text-xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-cyan-400 group-hover:to-blue-400 group-hover:bg-clip-text transition-all">Reportes Inteligentes</h3>
                <p class="text-slate-400 leading-relaxed group-hover:text-slate-300 transition-colors">
                  Visualiza tus ventas, inventario y finanzas con gráficos interactivos y reportes detallados.
                </p>
              </div>
              
              <!-- Shine effect -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>

            <!-- Feature 3 -->
            <div 
              class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden hover:bg-white/[0.04] hover:border-white/20 animate-fade-in"
              style="animation-delay: 0.3s; transition: background-color 0.5s ease, border-color 0.5s ease;"
              :style="featureStyles[2]"
              @mouseenter="onFeatureHover($event, 2)"
              @mousemove="onFeatureMove($event, 2)"
              @mouseleave="onFeatureLeave(2)"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-violet-500/0 via-violet-500/5 to-purple-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <div class="relative z-10">
                <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-violet-500/20 to-purple-500/20 border border-violet-500/30 flex items-center justify-center mb-6 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-8 h-8 text-violet-400 group-hover:text-violet-300 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                </div>
                <h3 class="text-xl font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-violet-400 group-hover:to-purple-400 group-hover:bg-clip-text transition-all">Seguridad Avanzada</h3>
                <p class="text-slate-400 leading-relaxed group-hover:text-slate-300 transition-colors">
                  Tus datos protegidos con encriptación de grado empresarial y autenticación segura.
                </p>
              </div>
              
              <!-- Shine effect -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- Stats Section -->
      <section class="py-24 px-6 relative">
        <div class="max-w-7xl mx-auto">
          <div class="grid grid-cols-2 md:grid-cols-4 gap-8 animate-fade-in">
            <div class="text-center group relative">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-accent-500/0 to-accent-500/0 group-hover:from-accent-500/20 group-hover:to-cyan-500/10 blur-2xl transition-all duration-500 opacity-0 group-hover:opacity-100"></div>
              <div class="text-5xl lg:text-6xl font-bold bg-gradient-to-r from-accent-400 to-cyan-400 bg-clip-text text-transparent mb-2 group-hover:scale-110 transition-transform duration-300 relative z-10">
                500+
              </div>
              <div class="text-slate-400 text-sm lg:text-base relative z-10">Ferreterías Activas</div>
            </div>
            <div class="text-center group relative">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-cyan-500/0 to-cyan-500/0 group-hover:from-cyan-500/20 group-hover:to-blue-500/10 blur-2xl transition-all duration-500 opacity-0 group-hover:opacity-100"></div>
              <div class="text-5xl lg:text-6xl font-bold bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent mb-2 group-hover:scale-110 transition-transform duration-300 relative z-10">
                99.9%
              </div>
              <div class="text-slate-400 text-sm lg:text-base relative z-10">Uptime Garantizado</div>
            </div>
            <div class="text-center group relative">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-violet-500/0 to-violet-500/0 group-hover:from-violet-500/20 group-hover:to-purple-500/10 blur-2xl transition-all duration-500 opacity-0 group-hover:opacity-100"></div>
              <div class="text-5xl lg:text-6xl font-bold bg-gradient-to-r from-violet-400 to-purple-400 bg-clip-text text-transparent mb-2 group-hover:scale-110 transition-transform duration-300 relative z-10">
                24/7
              </div>
              <div class="text-slate-400 text-sm lg:text-base relative z-10">Soporte Técnico</div>
            </div>
            <div class="text-center group relative">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-pink-500/0 to-pink-500/0 group-hover:from-pink-500/20 group-hover:to-rose-500/10 blur-2xl transition-all duration-500 opacity-0 group-hover:opacity-100"></div>
              <div class="text-5xl lg:text-6xl font-bold bg-gradient-to-r from-pink-400 to-rose-400 bg-clip-text text-transparent mb-2 group-hover:scale-110 transition-transform duration-300 relative z-10">
                +35%
              </div>
              <div class="text-slate-400 text-sm lg:text-base relative z-10">Aumento en Ventas</div>
            </div>
          </div>
        </div>
      </section>

      <!-- Benefits Section -->
      <section class="py-24 px-6 relative">
        <div class="max-w-7xl mx-auto">
          <div class="text-center mb-16">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent-500/10 border border-accent-500/20 text-accent-400 mb-6">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
              </svg>
              <span class="text-sm font-medium">¿Por qué FerreCloud?</span>
            </div>
            <h2 class="text-4xl lg:text-5xl font-bold text-white mb-4">
              Diseñado para <span class="bg-gradient-to-r from-white via-accent-400 to-cyan-500 bg-clip-text text-transparent animate-gradient-shift bg-[length:200%_auto]">Ferreterías Modernas</span>
            </h2>
            <p class="text-lg text-slate-400 max-w-2xl mx-auto">
              No es solo otro software de gestión. Es la solución completa que tu ferretería necesita.
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-5xl mx-auto">
            <!-- Benefit 1 -->
            <div class="group backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-300 animate-fade-in" style="animation-delay: 0.1s;">
              <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-accent-500/20 to-cyan-500/10 flex items-center justify-center flex-shrink-0 mt-1 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-5 h-5 text-accent-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <div>
                  <h3 class="text-lg font-semibold text-white mb-2">Ahorra Tiempo</h3>
                  <p class="text-slate-400 text-sm">Automatiza tareas repetitivas y reduce hasta 10 horas semanales de trabajo manual.</p>
                </div>
              </div>
            </div>

            <!-- Benefit 2 -->
            <div class="group backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-300 animate-fade-in" style="animation-delay: 0.2s;">
              <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-cyan-500/20 to-blue-500/10 flex items-center justify-center flex-shrink-0 mt-1 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-5 h-5 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                  </svg>
                </div>
                <div>
                  <h3 class="text-lg font-semibold text-white mb-2">Aumenta Ventas</h3>
                  <p class="text-slate-400 text-sm">Identifica productos más vendidos y optimiza tu inventario para maximizar ingresos.</p>
                </div>
              </div>
            </div>

            <!-- Benefit 3 -->
            <div class="group backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-300">
              <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-violet-500/20 to-purple-500/10 flex items-center justify-center flex-shrink-0 mt-1 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-5 h-5 text-violet-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                </div>
                <div>
                  <h3 class="text-lg font-semibold text-white mb-2">Control Total</h3>
                  <p class="text-slate-400 text-sm">Accede a tu negocio desde cualquier lugar. Web, móvil, tablet - siempre conectado.</p>
                </div>
              </div>
            </div>

            <!-- Benefit 4 -->
            <div class="group backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-300">
              <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-pink-500/20 to-rose-500/10 flex items-center justify-center flex-shrink-0 mt-1 group-hover:scale-110 group-hover:rotate-6 transition-all duration-500">
                  <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <div>
                  <h3 class="text-lg font-semibold text-white mb-2">Reduce Costos</h3>
                  <p class="text-slate-400 text-sm">Elimina errores de inventario y optimiza compras. Ahorra miles al año.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Testimonials Section -->
      <section class="py-24 px-6 relative">
        <div class="max-w-7xl mx-auto">
          <div class="text-center mb-16 animate-fade-in">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent-500/10 border border-accent-500/20 text-accent-400 mb-6 animate-fade-in" style="animation-delay: 0.1s;">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path d="M2 10.5a1.5 1.5 0 113 0v6a1.5 1.5 0 01-3 0v-6zM6 10.333v5.43a2 2 0 001.106 1.79l.05.025A4 4 0 008.943 18h5.416a2 2 0 001.962-1.608l1.2-6A2 2 0 0015.56 8H12V4a2 2 0 00-2-2 1 1 0 00-1 1v.667a4 4 0 01-.8 2.4L6.8 7.933a4 4 0 00-.8 2.4z" />
              </svg>
              <span class="text-sm font-medium">Testimonios</span>
            </div>
            <h2 class="text-4xl lg:text-5xl font-bold text-white mb-4 animate-fade-in" style="animation-delay: 0.2s;">
              Lo que dicen nuestros <span class="bg-gradient-to-r from-white via-cyan-400 to-blue-500 bg-clip-text text-transparent animate-gradient-shift bg-[length:200%_auto]">clientes</span>
            </h2>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Testimonial 1 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-105 hover:shadow-2xl hover:shadow-accent-500/20 animate-fade-in" style="animation-delay: 0.1s;">
              <div class="flex items-center gap-1 mb-4">
                <svg v-for="n in 5" :key="n" class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
              <p class="text-slate-300 mb-6 leading-relaxed">
                "Antes perdíamos horas controlando el inventario manualmente. Ahora todo fluye automáticamente. Nuestras ventas aumentaron un 40% en 6 meses."
              </p>
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-accent-500 to-cyan-500 flex items-center justify-center text-white font-bold">
                  JM
                </div>
                <div>
                  <div class="text-white font-semibold">José Martínez</div>
                  <div class="text-slate-500 text-sm">Ferretería El Constructor</div>
                </div>
              </div>
            </div>

            <!-- Testimonial 2 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-105 hover:shadow-2xl hover:shadow-cyan-500/20 animate-fade-in" style="animation-delay: 0.2s;">
              <div class="flex items-center gap-1 mb-4">
                <svg v-for="n in 5" :key="n" class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
              <p class="text-slate-300 mb-6 leading-relaxed">
                "La interfaz es increíblemente intuitiva. Mi equipo aprendió a usarlo en menos de un día. El soporte técnico es excepcional."
              </p>
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-blue-500 flex items-center justify-center text-white font-bold">
                  AR
                </div>
                <div>
                  <div class="text-white font-semibold">Ana Rodríguez</div>
                  <div class="text-slate-500 text-sm">Ferretería Central</div>
                </div>
              </div>
            </div>

            <!-- Testimonial 3 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-105 hover:shadow-2xl hover:shadow-violet-500/20 animate-fade-in" style="animation-delay: 0.3s;">
              <div class="flex items-center gap-1 mb-4">
                <svg v-for="n in 5" :key="n" class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
              <p class="text-slate-300 mb-6 leading-relaxed">
                "Los reportes en tiempo real han transformado cómo tomamos decisiones. Vemos exactamente qué productos rotan más y optimizamos compras."
              </p>
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-violet-500 to-purple-500 flex items-center justify-center text-white font-bold">
                  CG
                </div>
                <div>
                  <div class="text-white font-semibold">Carlos García</div>
                  <div class="text-slate-500 text-sm">Ferretería Progreso</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Pricing Section -->
      <section class="py-24 px-6 relative">
        <div class="max-w-7xl mx-auto">
          <div class="text-center mb-16 animate-fade-in">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent-500/10 border border-accent-500/20 text-accent-400 mb-6 animate-fade-in" style="animation-delay: 0.1s;">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span class="text-sm font-medium">Planes</span>
            </div>
            <h2 class="text-4xl lg:text-5xl font-bold text-white mb-4 animate-fade-in" style="animation-delay: 0.2s;">
              Precios <span class="bg-gradient-to-r from-white via-purple-400 to-pink-500 bg-clip-text text-transparent animate-gradient-shift bg-[length:200%_auto]">transparentes</span>
            </h2>
            <p class="text-lg text-slate-400 max-w-2xl mx-auto animate-fade-in" style="animation-delay: 0.3s;">
              Sin costos ocultos. Sin sorpresas. Cancela cuando quieras.
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
            <!-- Plan Básico -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-105 hover:shadow-2xl hover:shadow-accent-500/10 animate-fade-in" style="animation-delay: 0.1s;">
              <h3 class="text-xl font-bold text-white mb-2">Básico</h3>
              <div class="mb-6">
                <span class="text-4xl font-bold text-white">$29</span>
                <span class="text-slate-400">/mes</span>
              </div>
              <ul class="space-y-3 mb-8">
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Hasta 1,000 productos</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>1 usuario</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Reportes básicos</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Soporte por email</span>
                </li>
              </ul>
              <router-link 
                to="/auth/login"
                class="block w-full text-center px-6 py-3 rounded-xl border border-white/20 text-white font-medium hover:bg-white/5 transition-all duration-300"
              >
                Comenzar
              </router-link>
            </div>

            <!-- Plan Profesional (Popular) -->
            <div class="backdrop-blur-xl bg-gradient-to-br from-accent-500/10 to-cyan-500/5 rounded-2xl border-2 border-accent-500/50 p-8 relative hover:scale-110 transition-all duration-500 shadow-2xl shadow-accent-500/20 hover:shadow-accent-500/40 animate-fade-in" style="animation-delay: 0.2s;">
              <div class="absolute -top-4 left-1/2 -translate-x-1/2 px-4 py-1 rounded-full bg-gradient-to-r from-accent-500 to-cyan-500 text-white text-sm font-medium">
                Más Popular
              </div>
              <h3 class="text-xl font-bold text-white mb-2">Profesional</h3>
              <div class="mb-6">
                <span class="text-4xl font-bold text-white">$79</span>
                <span class="text-slate-400">/mes</span>
              </div>
              <ul class="space-y-3 mb-8">
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Productos ilimitados</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Hasta 5 usuarios</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Reportes avanzados</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Multi-tienda</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Soporte prioritario 24/7</span>
                </li>
              </ul>
              <router-link 
                to="/auth/login"
                class="block w-full text-center px-6 py-3 rounded-xl bg-gradient-to-r from-accent-500 to-cyan-500 text-white font-semibold hover:shadow-xl hover:shadow-accent-500/30 transition-all duration-300"
              >
                Comenzar Ahora
              </router-link>
            </div>

            <!-- Plan Empresarial -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-105 hover:shadow-2xl hover:shadow-violet-500/10 animate-fade-in" style="animation-delay: 0.3s;">
              <h3 class="text-xl font-bold text-white mb-2">Empresarial</h3>
              <div class="mb-6">
                <span class="text-4xl font-bold text-white">$149</span>
                <span class="text-slate-400">/mes</span>
              </div>
              <ul class="space-y-3 mb-8">
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Todo en Profesional</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Usuarios ilimitados</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>API personalizada</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Integración con ERP</span>
                </li>
                <li class="flex items-center gap-3 text-slate-300">
                  <svg class="w-5 h-5 text-accent-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Gerente de cuenta dedicado</span>
                </li>
              </ul>
              <router-link 
                to="/auth/login"
                class="block w-full text-center px-6 py-3 rounded-xl border border-white/20 text-white font-medium hover:bg-white/5 transition-all duration-300"
              >
                Contactar Ventas
              </router-link>
            </div>
          </div>

          <!-- Garantía -->
          <div class="mt-16 text-center animate-fade-in" style="animation-delay: 0.5s;">
            <div class="inline-flex items-center gap-3 backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 px-8 py-4 hover:bg-white/[0.04] hover:border-white/20 hover:scale-105 transition-all duration-300">
              <svg class="w-8 h-8 text-accent-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
              <div class="text-left">
                <div class="text-white font-semibold">Garantía de 30 días</div>
                <div class="text-slate-400 text-sm">Si no estás satisfecho, te devolvemos tu dinero. Sin preguntas.</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- FAQ Section -->
      <section class="py-24 px-6 relative">
        <div class="max-w-4xl mx-auto">
          <div class="text-center mb-16 animate-fade-in">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent-500/10 border border-accent-500/20 text-accent-400 mb-6 animate-fade-in" style="animation-delay: 0.1s;">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span class="text-sm font-medium">Preguntas Frecuentes</span>
            </div>
            <h2 class="text-4xl lg:text-5xl font-bold text-white mb-4 animate-fade-in" style="animation-delay: 0.2s;">
              ¿Tienes dudas?
            </h2>
          </div>

          <div class="space-y-4">
            <!-- FAQ 1 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-102 hover:shadow-lg hover:shadow-accent-500/10 animate-fade-in" style="animation-delay: 0.1s;">
              <h3 class="text-lg font-semibold text-white mb-2">¿Necesito conocimientos técnicos para usar FerreCloud?</h3>
              <p class="text-slate-400">No. FerreCloud está diseñado para ser intuitivo. Si sabes usar un navegador web, puedes usar FerreCloud. Además, ofrecemos capacitación gratuita.</p>
            </div>

            <!-- FAQ 2 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-102 hover:shadow-lg hover:shadow-cyan-500/10 animate-fade-in" style="animation-delay: 0.2s;">
              <h3 class="text-lg font-semibold text-white mb-2">¿Puedo migrar mi inventario actual?</h3>
              <p class="text-slate-400">Sí. Nuestro equipo te ayuda a importar todos tus datos existentes desde Excel, otro software o cualquier formato. Es completamente gratuito.</p>
            </div>

            <!-- FAQ 3 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-102 hover:shadow-lg hover:shadow-violet-500/10 animate-fade-in" style="animation-delay: 0.3s;">
              <h3 class="text-lg font-semibold text-white mb-2">¿Qué pasa con mis datos si cancelo?</h3>
              <p class="text-slate-400">Tus datos siempre son tuyos. Puedes exportarlos en cualquier momento. Si cancelas, mantenemos tus datos seguros por 90 días por si cambias de opinión.</p>
            </div>

            <!-- FAQ 4 -->
            <div class="backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-6 hover:bg-white/[0.04] hover:border-white/20 transition-all duration-500 hover:scale-102 hover:shadow-lg hover:shadow-pink-500/10 animate-fade-in" style="animation-delay: 0.4s;">
              <h3 class="text-lg font-semibold text-white mb-2">¿Funciona sin internet?</h3>
              <p class="text-slate-400">FerreCloud funciona mejor con conexión a internet, pero estamos trabajando en un modo offline que sincroniza automáticamente cuando vuelves a conectarte.</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Footer -->
      <footer class="border-t border-white/5 py-8 px-6">
        <div class="max-w-7xl mx-auto flex items-center justify-between text-sm text-slate-500">
          <div class="flex items-center gap-2">
            <div class="w-6 h-6 rounded-lg bg-gradient-to-br from-accent-400 to-cyan-500 flex items-center justify-center">
              <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
            </div>
            <span class="text-slate-400">FerreCloud © 2026</span>
          </div>
          <div class="flex items-center gap-6">
            <a href="#" class="hover:text-white transition-colors">Privacidad</a>
            <a href="#" class="hover:text-white transition-colors">Términos</a>
            <a href="#" class="hover:text-white transition-colors">Soporte</a>
          </div>
        </div>
      </footer>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted } from 'vue'

const containerRef = ref<HTMLElement>()
const mouseX = ref(0)
const mouseY = ref(0)
const scrollY = ref(0)
const scrollProgress = ref(0)
const cursorScale = ref(1)
const cursorVisible = ref(false)
const isHovering = ref(false)
const customCursorEnabled = ref(true)

// Feature card tilt effect
const featureStyles = reactive<Record<number, any>>({
  0: {},
  1: {},
  2: {}
})

const onMouseMove = (event: MouseEvent) => {
  mouseX.value = event.clientX
  mouseY.value = event.clientY
  cursorVisible.value = true
}

const handleScroll = () => {
  scrollY.value = window.scrollY
  
  // Calculate scroll progress
  const windowHeight = document.documentElement.scrollHeight - window.innerHeight
  scrollProgress.value = (window.scrollY / windowHeight) * 100
}

// Scroll-triggered animations
const setupScrollAnimations = () => {
  const observerOptions = {
    root: null,
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
  }

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-scroll-reveal')
        entry.target.classList.remove('scroll-hidden')
      }
    })
  }, observerOptions)

  // Observe all sections
  const sections = document.querySelectorAll('section')
  sections.forEach(section => {
    section.classList.add('scroll-hidden')
    observer.observe(section)
  })

  return observer
}

// Feature card tilt handlers
const onFeatureHover = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 15
  const rotateY = (centerX - x) / 15
  
  featureStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.03, 1.03, 1.03)`,
    transition: 'transform 0.1s ease'
  }
}

const onFeatureMove = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const rotateX = (y - centerY) / 15
  const rotateY = (centerX - x) / 15
  
  featureStyles[index] = {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.03, 1.03, 1.03)`,
    transition: 'none'
  }
}

const onFeatureLeave = (index: number) => {
  featureStyles[index] = {
    transform: 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)',
    transition: 'transform 0.6s cubic-bezier(0.16, 1, 0.3, 1)'
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  window.addEventListener('mouseleave', () => {
    cursorVisible.value = false
    isHovering.value = false
    cursorScale.value = 1
  })
  
  // Setup scroll animations after a short delay
  setTimeout(() => {
    setupScrollAnimations()
  }, 100)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* Animations */
@keyframes aurora {
  0%, 100% { opacity: 1; transform: scale(1) rotate(0deg); }
  33% { opacity: 0.8; transform: scale(1.1) rotate(5deg); }
  66% { opacity: 0.9; transform: scale(0.95) rotate(-5deg); }
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

@keyframes float-slow {
  0%, 100% { transform: translateY(0px) rotate(0deg); }
  50% { transform: translateY(-30px) rotate(5deg); }
}

@keyframes pulse-subtle {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 0.5; }
}

@keyframes fade-in {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes gradient-shift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

@keyframes scroll-reveal {
  from { 
    opacity: 0; 
    transform: translateY(50px) scale(0.95);
  }
  to { 
    opacity: 1; 
    transform: translateY(0) scale(1);
  }
}

.animate-aurora { animation: aurora 15s ease-in-out infinite; }
.animate-float { animation: float 6s ease-in-out infinite; }
.animate-float-slow { animation: float-slow 8s ease-in-out infinite; }
.animate-pulse-subtle { animation: pulse-subtle 4s ease-in-out infinite; }
.animate-fade-in { animation: fade-in 0.8s ease-out forwards; opacity: 0; }
.animate-gradient-shift { animation: gradient-shift 3s ease infinite; }

/* Scroll-triggered animations */
.scroll-hidden {
  opacity: 0;
  transform: translateY(50px) scale(0.95);
}

.animate-scroll-reveal {
  animation: scroll-reveal 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

/* Custom hover scale */
.hover\:scale-102:hover { transform: scale(1.02); }
.hover\:scale-110:hover { transform: scale(1.10); }

/* Auto-stagger animations for child elements */
.grid > *:nth-child(1) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.1s; opacity: 0; }
.grid > *:nth-child(2) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.2s; opacity: 0; }
.grid > *:nth-child(3) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.3s; opacity: 0; }
.grid > *:nth-child(4) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.4s; opacity: 0; }
.grid > *:nth-child(5) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.5s; opacity: 0; }
.grid > *:nth-child(6) { animation: fade-in 0.8s ease-out forwards; animation-delay: 0.6s; opacity: 0; }

/* Enhanced card hover effects */
.backdrop-blur-xl {
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.backdrop-blur-xl:hover {
  transform: translateY(-4px);
}

/* Cinematic Effects */
.cinematic-vignette {
  box-shadow: inset 0 0 200px rgba(0, 0, 0, 0.9);
}

.film-grain {
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
  background-repeat: repeat;
  background-size: 200px;
}

.cinematic-section {
  position: relative;
}
</style>
