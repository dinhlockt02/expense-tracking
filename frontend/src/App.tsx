import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Loader2 } from 'lucide-react'
import { useAuth } from 'react-oidc-context';
import { toast, Toaster } from 'sonner';
import { useEffect } from 'react';
import { env } from './env';


function App() {
  const auth = useAuth();

  const signOutRedirect = () => {
    const clientId = env.VITE_COGNITO_CLIENT_ID
    const logoutUri = env.VITE_COGNITO_REDIRECT_URI
    const cognitoDomain = env.VITE_COGNITO_DOMAIN
    window.location.href = `${cognitoDomain}/logout?client_id=${clientId}&logout_uri=${encodeURIComponent(logoutUri)}`
  }

  useEffect(() => {
    if (!!auth.error) {
      toast.error(`Authentication error: ${auth.error.message}`, {
        duration: 5000,
        position: 'top-center',
      });
      console.error('Authentication error:', auth.error);
    }
  }, [auth.error]);

  if (auth.isLoading) {
    return (
      <div className="flex items-center gap-3 justify-center min-h-screen">
        <Loader2 className="h-8 w-8 animate-spin text-blue-500" />
        <span className="text-lg text-gray-700">Loading...</span>
      </div>
    )
  }

  if (auth.isAuthenticated) {
    console.log('User is authenticated:', auth.user)
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-50 to-blue-100">
        <Card className="w-full max-w-md shadow-lg">
          <CardHeader>
            ß
            <CardTitle className="text-3xl font-bold text-center">
              Welcome back, {auth.user?.profile.name || 'User'}!
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="mb-6 text-center text-gray-600">
              This is a simple application to track your expenses.
            </p>
            <div className="flex justify-center gap-4">
              <Button onClick={() => auth.removeUser().then(() => signOutRedirect())}>Logout</Button>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <>
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-50 to-blue-100">
        <Card className="w-full max-w-md shadow-lg">
          <CardHeader>
            ß
            <CardTitle className="text-3xl font-bold text-center">
              Welcome to the Expense Tracking App
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="mb-6 text-center text-gray-600">
              This is a simple application to track your expenses.
            </p>
            <div className="flex justify-center gap-4">
              <Button onClick={() => auth.signinRedirect()}>Login</Button>
            </div>
          </CardContent>
        </Card>
      </div>
      <Toaster/>
    </>
  )
}

export default App
