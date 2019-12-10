//kabam.rotmg.account.securityQuestions.signals.SaveSecurityQuestionsSignal

package kabam.rotmg.account.securityQuestions.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsData;

    public class SaveSecurityQuestionsSignal extends Signal 
    {

        public function SaveSecurityQuestionsSignal()
        {
            super(SecurityQuestionsData);
        }

    }
}//package kabam.rotmg.account.securityQuestions.signals

