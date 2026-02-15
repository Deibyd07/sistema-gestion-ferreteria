import { createRouter, createWebHistory } from "vue-router";
import { useAuthStore } from "@/stores/auth";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      redirect: () => {
        const authStore = useAuthStore();
        return authStore.isAuthenticated ? "/dashboard" : "/home";
      },
    },
    {
      path: "/home",
      name: "home",
      component: () => import("@/views/HomeView.vue"),
      meta: { requiresAuth: false },
    },
    {
      path: "/auth",
      redirect: "/auth/login",
      children: [
        {
          path: "login",
          name: "login",
          component: () => import("@/views/auth/LoginView.vue"),
          meta: { requiresGuest: true },
        },
        {
          path: "register",
          name: "register",
          component: () => import("@/views/auth/RegisterView.vue"),
          meta: { requiresGuest: true },
        },
        {
          path: "forgot-password",
          name: "forgot-password",
          component: () => import("@/views/auth/ForgotPasswordView.vue"),
          meta: { requiresGuest: true },
        },
      ],
    },
    {
      path: "/dashboard",
      name: "dashboard",
      component: () => import("@/views/DashboardView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/showcase",
      name: "showcase",
      component: () => import("@/views/ComponentShowcase.vue"),
      meta: { requiresAuth: false },
    },
    // Catch all - 404
    {
      path: "/:pathMatch(.*)*",
      redirect: "/",
    },
  ],
});

// Navigation Guards
router.beforeEach((to, from, next) => {
  const authStore = useAuthStore();

  // Esperar a que se inicialice la autenticación
  if (authStore.isLoading) {
    // Esperar inicialización
    const unwatch = authStore.$subscribe(() => {
      if (!authStore.isLoading) {
        unwatch();
        handleNavigation();
      }
    });
  } else {
    handleNavigation();
  }

  function handleNavigation() {
    const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
    const requiresGuest = to.matched.some((record) => record.meta.requiresGuest);

    if (requiresAuth && !authStore.isAuthenticated) {
      // Ruta requiere autenticación pero el usuario no está autenticado
      next({ name: "login", query: { redirect: to.fullPath } });
    } else if (requiresGuest && authStore.isAuthenticated) {
      // Ruta para invitados pero el usuario está autenticado
      next({ name: "dashboard" });
    } else {
      // Todo bien, continuar
      next();
    }
  }
});

export default router;
