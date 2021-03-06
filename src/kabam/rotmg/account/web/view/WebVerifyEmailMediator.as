//kabam.rotmg.account.web.view.WebVerifyEmailMediator

package kabam.rotmg.account.web.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.account.core.signals.SendConfirmEmailSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.service.TrackingData;

    public class WebVerifyEmailMediator extends Mediator 
    {

        [Inject]
        public var view:WebVerifyEmailDialog;
        [Inject]
        public var account:Account;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var verify:SendConfirmEmailSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var updateAccount:UpdateAccountInfoSignal;


        override public function initialize():void
        {
            this.view.setUserInfo(this.account.getUserName(), this.account.isVerified());
            this.view.verify.add(this.onVerify);
            this.view.logout.add(this.onLogout);
        }

        override public function destroy():void
        {
            this.view.verify.remove(this.onVerify);
            this.view.logout.remove(this.onLogout);
        }

        private function onVerify():void
        {
            var _local_1:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            _local_1.complete.addOnce(this.onComplete);
            _local_1.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
        }

        private function onLogout():void
        {
            this.trackLoggedOut();
            this.account.clear();
            this.updateAccount.dispatch();
            this.openDialog.dispatch(new WebLoginDialog());
        }

        private function trackLoggedOut():void
        {
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "account";
            _local_1.action = "loggedOut";
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onSent();
            }
            else
            {
                this.onError(_arg_2);
            };
        }

        private function onSent():void
        {
        }

        private function trackEmailSent():void
        {
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "account";
            _local_1.action = "verifyEmailSent";
        }

        private function onError(_arg_1:String):void
        {
            this.account.clear();
        }


    }
}//package kabam.rotmg.account.web.view

