import { createClient } from '@supabase/supabase-js';

// GitHub Pages loads this file before the React bundle.
// Keep the runtime config in public/supabase-config.js so the key never has to be
// hard-coded into the source bundle.
const runtimeConfig = typeof window !== 'undefined' ? (window.__SUPABASE_CONFIG__ || {}) : {};

const rawUrl = import.meta.env.VITE_SUPABASE_URL || runtimeConfig.url || '';
const rawKey = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY || runtimeConfig.publishableKey || '';

// A Project URL must be the project root, not the Data API route.
// This also protects against the common mistake of pasting .../rest/v1/.
const normalizeProjectUrl = (value) => {
  const input = String(value || '').trim();
  if (!input) return '';
  return input.replace(/\/rest\/v1\/?$/i, '').replace(/\/$/, '');
};

const url = normalizeProjectUrl(rawUrl);
const key = String(rawKey || '').trim();

export const supabaseConfig = { url, key };
export const supabaseEnabled = Boolean(url && key);

// Explicitly provide the apikey header as well as the key argument.
// Supabase's publishable keys are meant for browser apps and are sent as
// the `apikey` header. This makes the client behavior unambiguous.
export const supabase = supabaseEnabled
  ? createClient(url, key, {
      global: {
        headers: {
          apikey: key,
        },
      },
    })
  : null;
