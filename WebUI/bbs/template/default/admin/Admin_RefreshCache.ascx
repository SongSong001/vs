<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->系统数据重计
        </div>
        <div class="M1 Middle">
            <div class="BT LH25 Hidden" style="height:30px">
				<div class="Left" style="width: 300px">
					&nbsp;重计用户数据：包括用户总数，男女比例
				</div>
				<div class="Left">
					<asp:Button CssClass="Button" ID="RefreshUser" Text="确定重计" runat="server" />
				</div>
            </div>
            <div class="BT LH25 Hidden" style="height:30px">
				<div class="Left" style="width: 300px">
					&nbsp;重计版面数据：包括论坛总贴和每个版面的帖子总数
				</div>
				<div class="Left">
					<asp:Button CssClass="Button" ID="RefreshBoard" Text="确定重计" runat="server" />
				</div>
			</div>
            <div class="BT LH25 Hidden" style="height:30px">
				<div class="Left" style="width: 300px">
					&nbsp;刷新系统缓存：重新刷新整个系统的所有缓存数据
				</div>
				<div class="Left">
					<asp:Button CssClass="Button" ID="RefreshCache" Text="确定刷新" runat="server" />
				</div>
			</div>
		</div>
	</div>
</div>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->回复重计/垃圾清除(需要较长时间运行,不建议执行)
        </div>
        <div class="M1 Middle">
            <div class="BT LH25 Hidden" style="height:30px">
				<div class="Left" style="width: 300px">
					&nbsp;重计帖子数据：重计每个主题对应的回复数
				</div>
				<div class="Left">
					<asp:Button CssClass="Button" ID="RefreshTopic" Text="确定重计" runat="server" />
				</div>
			</div>
            <div class="BT LH25 Hidden" style="height:30px">
				<div class="Left" style="width: 300px">
					&nbsp;垃圾数据清除：清除一些由不明原因造成的垃圾数据
				</div>
				<div class="Left">
					<asp:Button CssClass="Button" ID="RefreshTrash" Text="确定刷新" runat="server" />
				</div>
			</div>
		</div>
	</div>
</div>