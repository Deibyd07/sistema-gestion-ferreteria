import { ref, readonly } from "vue";

export interface Toast {
  id: number;
  title: string;
  description?: string;
  variant: "success" | "error" | "warning" | "info";
  duration: number;
  action?: {
    label: string;
    onClick: () => void;
  };
}

const toasts = ref<Toast[]>([]);
let id = 0;

export function useToast() {
  const add = (toast: Omit<Toast, "id">) => {
    const newToast: Toast = {
      ...toast,
      id: id++,
    };

    toasts.value.push(newToast);

    if (newToast.duration > 0) {
      setTimeout(() => {
        remove(newToast.id);
      }, newToast.duration);
    }

    return newToast.id;
  };

  const remove = (id: number) => {
    const index = toasts.value.findIndex((t) => t.id === id);
    if (index > -1) {
      toasts.value.splice(index, 1);
    }
  };

  const success = (title: string, options?: Partial<Omit<Toast, "id" | "variant">>) => {
    return add({
      title,
      variant: "success",
      duration: 4000,
      ...options,
    });
  };

  const error = (title: string, options?: Partial<Omit<Toast, "id" | "variant">>) => {
    return add({
      title,
      variant: "error",
      duration: 6000,
      ...options,
    });
  };

  const warning = (title: string, options?: Partial<Omit<Toast, "id" | "variant">>) => {
    return add({
      title,
      variant: "warning",
      duration: 5000,
      ...options,
    });
  };

  const info = (title: string, options?: Partial<Omit<Toast, "id" | "variant">>) => {
    return add({
      title,
      variant: "info",
      duration: 4000,
      ...options,
    });
  };

  const promise = async <T>(
    promiseFn: Promise<T>,
    messages: {
      loading: string;
      success: string | ((data: T) => string);
      error: string | ((error: any) => string);
    },
  ) => {
    const loadingId = add({
      title: messages.loading,
      variant: "info",
      duration: 0,
    });

    try {
      const data = await promiseFn;
      remove(loadingId);
      success(typeof messages.success === "function" ? messages.success(data) : messages.success);
      return data;
    } catch (err) {
      remove(loadingId);
      error(typeof messages.error === "function" ? messages.error(err) : messages.error);
      throw err;
    }
  };

  return {
    toasts: readonly(toasts),
    add,
    remove,
    success,
    error,
    warning,
    info,
    promise,
  };
}
